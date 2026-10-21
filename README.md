# AllyMailer Ruby SDK

[![Ruby](https://img.shields.io/gem/v/allymailer-ruby-sdk)](https://rubygems.org/gems/allymailer-ruby-sdk) [![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

Офіційна бібліотека Ruby для API транзакційних листів [AllyMailer](https://allymailer.com.ua).

[Довідник API](https://docs.allymailer.com.ua/ua/web-api-ref) · Документація для LLM: [llms.txt](https://docs.allymailer.com.ua/llms.txt)

> **Ruby on Rails?** Встановіть [`allymailer-rails`](https://github.com/allymailer/allymailer-rails): у ньому цей SDK, налаштування, поштовий транспорт і маршрут для вебхуків.

## Встановлення

```bash
gem install allymailer-ruby-sdk
```

Вимоги: Ruby 2.7+. Сторонніх залежностей немає.

Отримайте API-ключ у [панелі керування](https://cp.allymailer.com) і зберігайте його у змінній оточення, а не в коді:

```bash
export ALLYMAILER_API_KEY="your-api-key"
```

## Надсилання листа

```ruby
require 'allymailer'

Body = AllyMailer::Common::Model::BodyObject
Email = AllyMailer::Api::Email::Model
Recipient = AllyMailer::Api::Email::Model::MessageObjectRecipientsItem

client = AllyMailer.client(ENV.fetch('ALLYMAILER_API_KEY'))

message = Email::MessageObject.new(
  recipients: [Recipient.from_address('Олексій <alex@example.com>')],
  body: Body.html('<p>Вітаємо, {{to_name}}! Ваше замовлення надіслано.</p>'),
  subject: 'Ваше замовлення',
  from_email: 'shop@example.com',
  from_name: 'Магазин'
)
response = client.email.send_email(Email::EmailSendRequest.new(message: message))
puts response.job_id
```

Адреса відправника має бути на домені, підтвердженому у вашому обліковому записі. Домену ще немає? Надішліть лист із [sandbox-домену](#без-свого-домену-тестовий-sandbox-домен) у три кроки.

## Зміст

- [Рецепти](#рецепти): персоналізація · вкладення · копія і прихована копія · відкладене надсилання · безпечний повтор · помилки · вебхуки
- [Без свого домену: тестовий sandbox-домен](#без-свого-домену-тестовий-sandbox-домен)
- [Запуск у продакшен](#запуск-у-продакшен)
- [Довідник](#довідник)
- [Допомога](#допомога)

## Рецепти

Кожен рецепт продовжує приклад вище: клієнт та імпорти вже є.

### Персоналізація для кожного одержувача

До 500 одержувачів в одному виклику, кожен отримує окрему копію зі своїми підстановками. Метадані одержувача повертаються в його подіях вебхука.

```ruby
message = Email::MessageObject.new(
  recipients: [
    Recipient.from_address('Олексій <alex@example.com>', { 'order' => '1001' }).with_metadata({ 'user_id' => '42' }),
    Recipient.from_address('Марія <maria@example.com>', { 'order' => '1002' }).with_metadata({ 'user_id' => '43' })
  ],
  body: Body.html('<p>{{to_name}}, замовлення №{{order}} надіслано.</p>'),
  subject: 'Замовлення №{{order}}',
  from_email: 'shop@example.com'
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

### Вкладення

```ruby
Common = AllyMailer::Common::Model

message = Email::MessageObject.new(
  recipients: [Recipient.from_address('alex@example.com')],
  body: Body.html('<p>Рахунок у вкладенні.</p>'),
  subject: 'Рахунок',
  from_email: 'shop@example.com',
  attachments: [
    Common::AttachmentsArrayItem.new(
      type: 'application/pdf',
      name: 'invoice.pdf',
      content: [File.binread('invoice.pdf')].pack('m0')
    )
  ]
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

### Копія і прихована копія

Усі адреси передаються в `recipients` (кожна отримує копію), видимі — ще й у заголовках. `audit@example.com` немає в жодному заголовку: це прихована копія. Правила й обмеження: [копія і прихована копія](https://docs.allymailer.com.ua/ua/cc-and-bcc).

```ruby
Common = AllyMailer::Common::Model

message = Email::MessageObject.new(
  recipients: [
    Recipient.from_address('alex@example.com'),
    Recipient.from_address('boss@example.com'),
    Recipient.from_address('audit@example.com')
  ],
  body: Body.html('<p>Звіт у вкладенні.</p>'),
  subject: 'Звіт за тиждень',
  from_email: 'shop@example.com',
  headers: Common::HeadersObject.new(extra: { 'To' => 'alex@example.com', 'CC' => 'boss@example.com' })
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

### Відкладене надсилання

`send_at` — в UTC, не далі ніж на 24 години вперед.

```ruby
send_at = (Time.now.utc + 3600).strftime('%Y-%m-%d %H:%M:%S') # UTC, "YYYY-MM-DD hh:mm:ss"
message = Email::MessageObject.new(
  recipients: [Recipient.from_address('alex@example.com')],
  body: Body.text('До зустрічі завтра!'),
  subject: 'Нагадування',
  from_email: 'shop@example.com',
  options: Email::MessageObjectOptions.new(send_at: send_at)
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

### Безпечний повтор

Повтор із тим самим `idempotence_key` протягом хвилини не надішлеться вдруге: з ним повторюйте мережеві помилки, таймаути, 429 і 5xx.

```ruby
message = Email::MessageObject.new(
  recipients: [Recipient.from_address('alex@example.com')],
  body: Body.html('<p>Посилання для скидання пароля.</p>'),
  subject: 'Скидання пароля',
  from_email: 'shop@example.com',
  idempotence_key: 'password-reset-8f3a'
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

### Обробка помилок

Одержувачі, яких API відкинув (відписані, неіснуючі, у стоп-листі), — не помилка: вони у `failed_emails` відповіді, решта лист отримає.

```ruby
begin
  client.email.send_email(request)
rescue AllyMailer::Client::ApiError => e
  # HTTP-статус (0: мережева помилка або таймаут), код помилки API, повідомлення
  puts "#{e.http_status} #{e.error_code}: #{e.message}"
end
```

### Статуси доставки

Зареєструйте свою HTTPS-адресу один раз (`webhook/set`). Потім перевіряйте підпис кожного сповіщення (`auth`: MD5 сирого тіла, у якому значення `auth` замінено на API-ключ; на неправильний — 401) і обробляйте події.

```ruby
require 'digest'

# raw: тіло POST-запиту як надійшло; повертає HTTP-статус відповіді
def handle_webhook(raw)
  callback = AllyMailer::Api::Webhook::WebhookApi.parse_callback(raw)
  auth = callback.auth.to_s
  # auth: MD5 сирого тіла, у якому значення auth замінено на ваш API-ключ
  return 401 unless Digest::MD5.hexdigest(raw.gsub(auth, ENV.fetch('ALLYMAILER_API_KEY'))) == auth

  (callback.events_by_user || []).each do |user|
    (user.events || []).each do |event|
      # email, status (delivered, opened, hard_bounced, spam, ...), job_id, metadata
    end
  end
  200
end
```

> **Відповідайте 200 протягом 3 секунд**, а події обробляйте у фоні (через чергу): інакше AllyMailer повторює запит кожні 10 хвилин протягом доби (зростає `retry_count`), а обробник, на якому за добу не пройшов жоден запит хоча б для 10 подій, вимикається. Обробник має витримувати **щонайменше 5 паралельних запитів до 100 подій у кожному**; повтор надсилає ті самі події ще раз — прибирайте дублікати.

## Без свого домену: тестовий sandbox-домен

Поки ваш домен не підтверджено, листи можна надсилати із **sandbox-домену** — тестового домену, який є в кожного облікового запису: він уже підтверджений, DKIM і SPF налаштовані. Листи з нього доставляються лише на підтверджені вами адреси (посилання для підтвердження приходить листом і діє 48 годин), до 100 на день. Через 31 день після створення sandbox-домен видаляється, але його можна отримати знову: наступний виклик `domain/get-sandbox-domain` створить новий (з іншою назвою, тому беріть її з відповіді, а не прописуйте в коді).

```ruby
ConfirmedEmail = AllyMailer::Api::ConfirmedEmail::Model

# 1. Ваш sandbox-домен: створюється під час першого виклику, далі повертається той самий
domain = client.domain.get_sandbox_domain.domain

# 2. Підтвердіть свою скриньку: AllyMailer надішле посилання, перейдіть за ним протягом 48 годин
client.confirmed_email.create(ConfirmedEmail::ConfirmedEmailRequest.new(email: 'you@example.com'))

# 3. Надішліть із будь-якої адреси sandbox-домену на підтверджену адресу
message = Email::MessageObject.new(
  recipients: [Recipient.from_address('you@example.com')],
  body: Body.html('<p>Працює!</p>'),
  subject: 'Привіт від AllyMailer',
  from_email: "noreply@#{domain}"
)
client.email.send_email(Email::EmailSendRequest.new(message: message))
```

<details>
<summary>Обмеження sandbox</summary>

- Надсилання лише на підтверджені адреси: до 10 на обліковий запис.
- До 100 листів на день.
- Sandbox-домен спливає через 31 день; знову викличте `domain/get-sandbox-domain`, щоб отримати новий.
- Працює лише з API-ключем облікового запису, не з ключем проєкту.
- Не показується в `domain/list`; інші методи `domain/*` до нього не застосовуються.

Sandbox — для розробки та тестування. Не використовуйте sandbox-домен як відправника на проді.

</details>

<details>
<summary>Те саме через curl</summary>

```bash
BASE=https://cp.allymailer.com/ua/transactional/api/v1

curl -s -X POST $BASE/domain/get-sandbox-domain.json \
  -H "Content-Type: application/json" -H "X-API-KEY: $ALLYMAILER_API_KEY" -d '{}'

curl -s -X POST $BASE/confirmed-email/create.json \
  -H "Content-Type: application/json" -H "X-API-KEY: $ALLYMAILER_API_KEY" \
  -d '{"email": "you@example.com"}'

curl -s -X POST $BASE/email/send.json \
  -H "Content-Type: application/json" -H "X-API-KEY: $ALLYMAILER_API_KEY" \
  -d '{
        "message": {
          "recipients": [
            {
              "email": "you@example.com"
            }
          ],
          "from_email": "noreply@<sandbox-domain>",
          "subject": "Привіт від AllyMailer",
          "body": {
            "html": "<p>Працює!</p>"
          }
        }
      }'
```

</details>

## Запуск у продакшен

**1. Підтвердіть домен надсилання.** `domain/get-dns-records` повертає запис підтвердження, DKIM-ключ і адресу для DMARC; додайте записи у свого DNS-провайдера, потім `domain/validate-verification-record` і `domain/validate-dkim`.

| Тип | Хост | Значення | Звідки взяти |
|---|---|---|---|
| TXT | `@` | `allymailer-validate-hash=…` | поле `verification-record` відповіді, як є |
| TXT | `<селектор>._domainkey` (селектор — на сторінці домену в панелі керування, наприклад `us`) | `v=DKIM1; k=rsa; p=<dkim>` | поле `dkim` відповіді після `v=DKIM1; k=rsa; p=` |
| TXT | `@` | `v=spf1 include:spf.allymailer.com ~all` | у відповіді немає; якщо SPF-запис уже є, додайте include до нього |
| CNAME | `_dmarc` | `<домен>.dmarc.…` | поле `dmarc` відповіді (DMARC-політику публікує AllyMailer); якщо в домену вже є свій TXT-запис DMARC, залиште його |

**2. Надійне надсилання.**

| | |
|---|---|
| Повтори | `429` і `5xx` з backoff і тим самим `idempotence_key`; інші помилки виправляйте, а не повторюйте |
| Ліміти | 500 одержувачів і 10 МБ на запит разом із вкладеннями: у base64 файл стає приблизно на третину більшим |
| Тіло | завжди `html` або `plaintext` (або із шаблону) |
| Статус доставки | вебхук, а не опитування |
| Черга | надсилайте з фонового завдання, а не всередині веб-запиту |
| Налаштування | `from_email` з конфігурації: перехід із sandbox на продакшен без змін у коді |
| Типові налаштування | не прибирайте блок відписки та трекінг; змінити їх можна через підтримку AllyMailer |

## Довідник

### Розділи

| Розділ | Методи | Опис |
|---|---|---|
| [Email](docs/Email.md) | `send_email`, `subscribe` | Ця група методів пов'язана з надсиланням email. |
| [EmailValidation](docs/EmailValidation.md) | `single` | Методи перевірки email-адрес. Перевірка адреси електронної пошти надає докладну інформацію про працездатність email. Це дозволить виключити з надсилання неіснуючі email, знизити показник скарг, очистити список підписників і врешті-решт покращити вашу репутацію як відправника. Наприклад, ви можете інтегрувати процес перевірки у форму реєстрації вашого сайту і вже на етапі введення адреси повідомляти користувачам, що адреса, яку вони ввели у форму, недійсна. |
| [ConfirmedEmail](docs/ConfirmedEmail.md) | `create`, `list`, `delete` | Керування email-адресами, підтвердженими для надсилання із sandbox-домену. Методи доступні лише з API-ключем основного облікового запису. |
| [Template](docs/Template.md) | `set`, `get`, `list`, `delete` | Ви можете зберегти шаблон на боці AllyMailer і потім посилатися на нього за ідентифікатором. Це не обов'язково, але вкрай рекомендовано у разі повторюваних email-повідомлень або за великих обсягів надсилання. AllyMailer підтримує два різні синтаксиси для шаблонів, докладніше читайте [тут](https://docs.allymailer.com.ua/ua/template-engines). |
| [Webhook](docs/Webhook.md) | `set`, `get`, `list`, `delete` | AllyMailer дозволяє вам отримувати сповіщення про зміну статусу доставки листа або спам-блокування. Ви надаєте URL, і в разі виникнення події, що вас цікавить, ми сповіщаємо вас, передаючи на цей URL JSON-дані про подію. |
| [Suppression](docs/Suppression.md) | `set`, `get`, `list`, `delete` | Методи для керування адресами, надсилання на які заблоковано з різних причин — відписка, недоступність, скарги. |
| [Domain](docs/Domain.md) | `get_dns_records`, `validate_verification_record`, `validate_dkim`, `list`, `get_sandbox_domain`, `delete` | Методи для налаштування доменів надсилання та перевірки їх статусів. Корисні, якщо вам недостатньо додавання доменів через вебінтерфейс AllyMailer і, наприклад, хочеться автоматизувати додавання доменів для ваших власних клієнтів. |
| [EventDump](docs/EventDump.md) | `create`, `get`, `list`, `delete` | Методи для отримання списку подій, що сталися, за певний період. Дані зберігаються до 45 днів, залежно від вашого тарифу. Це означає, що можна запросити події, починаючи з 00:00:00 45-го дня тому і до поточного моменту часу. Для індивідуальних тарифів з великими обсягами за замовчуванням події доступні лише за останні 7 днів. |
| [Tag](docs/Tag.md) | `list`, `delete` | Методи керування користувацькими мітками. За допомогою міток ви можете класифікувати листи за потрібними критеріями. Відокремити маркетингові листи від транзакційних або листи з підтвердженням реєстрації від сповіщень про замовлення. AllyMailer дозволяє позначати мітками кожне вихідне повідомлення, а потім сегментувати й аналізувати статистику на основі зазначених під час надсилання міток. |
| [Project](docs/Project.md) | `create`, `update`, `list`, `delete` | Проєкти дозволяють об'єднати кілька незалежних доменів із webhook, шаблонами та списками відписки. Це дуже корисно, якщо у вас є власні клієнти і ви керуєте їхніми даними з одного облікового запису AllyMailer. Кожен проєкт отримує власний ключ API, а виклики методів API з цим ключем обробляють лише дані цього проєкту. Таким чином, ви можете призначити окремий проєкт для кожного користувача і бути впевненими, що вони не конфліктуватимуть: наприклад, відписка від одного проєкту не вплине на інший. |
| [System](docs/System.md) | `ping`, `info` | Системні методи. |
| [Obsolete](docs/Obsolete.md) | `unsubscribed_set`, `unsubscribed_check`, `unsubscribed_list` | Застарілі методи роботи з відписками. Ми рекомендуємо користуватися замість них гнучкішими методами [suppression](https://docs.allymailer.com.ua/ua/web-api-ref#suppression). Зверніть увагу, що знову підписати відписаного адресата через WebAPI не можна. Можна лише надіслати йому email із посиланням повторної підписки за допомогою методу email/subscribe. |

### Власний HTTP-клієнт / заголовки

`headers:` додає HTTP-заголовки до кожного запиту. `transport:` замінює HTTP-шар: будь-який об'єкт з методом `call(method, uri, headers, body, timeout)`, що повертає `[status, body]` (підійде й lambda). Оберніть стандартний `Client::NetHttpTransport` для повторів чи логування або викликайте Faraday / HTTParty у власному; виняток транспорту стає `ApiError`.

```ruby
require 'allymailer'

# Logs every request and retries network failures and HTTP 5xx.
class RetryTransport
  def initialize(inner = AllyMailer::Client::NetHttpTransport.new, attempts: 3)
    @inner = inner
    @attempts = attempts
  end

  def call(method, uri, headers, body, timeout)
    (1..@attempts).each do |attempt|
      puts "#{method} #{uri}"
      begin
        status, raw = @inner.call(method, uri, headers, body, timeout)
        return [status, raw] if status < 500 || attempt == @attempts
      rescue StandardError
        raise if attempt == @attempts
      end
      sleep attempt
    end
  end
end

client = AllyMailer.client('YOUR_API_KEY', transport: RetryTransport.new, headers: { 'X-Request-Id' => '42' })
```

Моделі з довільними ключами (`HeadersObject`) мають хеш `extra`: його ключі передаються поруч з іменованими полями.

```ruby
require 'allymailer'

headers = AllyMailer::Common::Model::HeadersObject.new(extra: {
  'X-MyHeader' => 'some data',
  'CC' => 'copy@example.com',
  'List-Unsubscribe' => '<mailto:unsubscribe@example.com>'
})
```

### Обробка помилок

Кожен метод кидає `ApiError`, якщо API повернув помилку; у ньому є [код помилки API](https://docs.allymailer.com.ua/ua/web-api-ref#api-errors) і HTTP-статус.

## Допомога

- Для ШІ-агентів: [llms.txt](https://docs.allymailer.com.ua/llms.txt), скіли: `npx skills add https://github.com/allymailer/allymailer-skills.git`
- [Підтримка](https://cp.allymailer.com/ua/support) · [Задачі](https://github.com/allymailer/allymailer-ruby-sdk/issues)
- Розробникам: [AGENTS.md](AGENTS.md) — SDK генерується з OpenAPI-специфікації.
