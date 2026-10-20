# frozen_string_literal: true

module AllyMailer
  # Entry point of the AllyMailer API: one method per section.
  #
  #   client = AllyMailer.client('YOUR_API_KEY')
  #   client.email.send_email(...)
  class AllyMailerClient
    # @return [Client::ApiClient]
    attr_reader :api_client

    # @param api_key [String]
    # @param host [String, nil] API host (Client::Configuration::HOST_CP, 'cp.allymailer.com') or a full base URL
    # @param transport [#call, nil] HTTP layer: call(method, uri, headers, body, timeout) -> [status, body];
    #   nil: Client::NetHttpTransport
    # @param options [Hash] of Client::Configuration: timeout:, platform:, headers: (extra HTTP headers)
    def initialize(api_key, host = nil, transport: nil, **options)
      options = options.merge(base_url: Client::Configuration.base_url_for(host)) if host
      @api_client = Client::ApiClient.new(Client::Configuration.new(api_key, **options), transport: transport)
    end

    # Ця група методів пов'язана з надсиланням email.
    # @return [Api::Email::EmailApi]
    def email
      @email ||= Api::Email::EmailApi.new(@api_client)
    end

    # Методи перевірки email-адрес. Перевірка адреси електронної пошти надає докладну інформацію про
    # працездатність email. Це дозволить виключити з надсилання неіснуючі email, знизити показник скарг,
    # очистити список підписників і врешті-решт покращити вашу репутацію як відправника. Наприклад, ви
    # можете інтегрувати процес перевірки у форму реєстрації вашого сайту і вже на етапі введення адреси
    # повідомляти користувачам, що адреса, яку вони ввели у форму, недійсна.
    # @return [Api::EmailValidation::EmailValidationApi]
    def email_validation
      @email_validation ||= Api::EmailValidation::EmailValidationApi.new(@api_client)
    end

    # Керування email-адресами, підтвердженими для надсилання із sandbox-домену. Методи доступні лише з
    # API-ключем основного облікового запису.
    # @return [Api::ConfirmedEmail::ConfirmedEmailApi]
    def confirmed_email
      @confirmed_email ||= Api::ConfirmedEmail::ConfirmedEmailApi.new(@api_client)
    end

    # Ви можете зберегти шаблон на боці AllyMailer і потім посилатися на нього за ідентифікатором. Це не
    # обов'язково, але вкрай рекомендовано у разі повторюваних email-повідомлень або за великих обсягів
    # надсилання. AllyMailer підтримує два різні синтаксиси для шаблонів, докладніше читайте
    # [тут](https://docs.allymailer.com.ua/en/template-engines).
    # @return [Api::Template::TemplateApi]
    def template
      @template ||= Api::Template::TemplateApi.new(@api_client)
    end

    # AllyMailer дозволяє вам отримувати сповіщення про зміну статусу доставки листа або спам-блокування.
    # Ви надаєте URL, і в разі виникнення події, що вас цікавить, ми сповіщаємо вас, передаючи на цей URL
    # JSON-дані про подію.
    # @return [Api::Webhook::WebhookApi]
    def webhook
      @webhook ||= Api::Webhook::WebhookApi.new(@api_client)
    end

    # Методи для керування адресами, надсилання на які заблоковано з різних причин — відписка,
    # недоступність, скарги.
    # @return [Api::Suppression::SuppressionApi]
    def suppression
      @suppression ||= Api::Suppression::SuppressionApi.new(@api_client)
    end

    # Методи для налаштування доменів надсилання та перевірки їх статусів. Корисні, якщо вам недостатньо
    # додавання доменів через вебінтерфейс AllyMailer і, наприклад, хочеться автоматизувати додавання
    # доменів для ваших власних клієнтів.
    # @return [Api::Domain::DomainApi]
    def domain
      @domain ||= Api::Domain::DomainApi.new(@api_client)
    end

    # Методи для отримання списку подій, що сталися, за певний період. Дані зберігаються до 45 днів,
    # залежно від вашого тарифу. Це означає, що можна запросити події, починаючи з 00:00:00 45-го дня тому
    # і до поточного моменту часу. Для індивідуальних тарифів з великими обсягами за замовчуванням події
    # доступні лише за останні 7 днів.
    # @return [Api::EventDump::EventDumpApi]
    def event_dump
      @event_dump ||= Api::EventDump::EventDumpApi.new(@api_client)
    end

    # Методи керування користувацькими мітками. За допомогою міток ви можете класифікувати листи за
    # потрібними критеріями. Відокремити маркетингові листи від транзакційних або листи з підтвердженням
    # реєстрації від сповіщень про замовлення. AllyMailer дозволяє позначати мітками кожне вихідне
    # повідомлення, а потім сегментувати й аналізувати статистику на основі зазначених під час надсилання
    # міток.
    # @return [Api::Tag::TagApi]
    def tag
      @tag ||= Api::Tag::TagApi.new(@api_client)
    end

    # Проєкти дозволяють об'єднати кілька незалежних доменів із webhook, шаблонами та списками відписки.
    # Це дуже корисно, якщо у вас є власні клієнти і ви керуєте їхніми даними з одного облікового запису
    # AllyMailer. Кожен проєкт отримує власний ключ API, а виклики методів API з цим ключем обробляють
    # лише дані цього проєкту. Таким чином, ви можете призначити окремий проєкт для кожного користувача і
    # бути впевненими, що вони не конфліктуватимуть: наприклад, відписка від одного проєкту не вплине на
    # інший.
    # @return [Api::Project::ProjectApi]
    def project
      @project ||= Api::Project::ProjectApi.new(@api_client)
    end

    # Системні методи.
    # @return [Api::System::SystemApi]
    def system
      @system ||= Api::System::SystemApi.new(@api_client)
    end

    # Застарілі методи роботи з відписками. Ми рекомендуємо користуватися замість них гнучкішими методами
    # [suppression](https://docs.allymailer.com.ua/ua/web-api-ref#suppression). Зверніть увагу, що знову
    # підписати відписаного адресата через WebAPI не можна. Можна лише надіслати йому email із посиланням
    # повторної підписки за допомогою методу email/subscribe.
    # @return [Api::Obsolete::ObsoleteApi]
    def obsolete
      @obsolete ||= Api::Obsolete::ObsoleteApi.new(@api_client)
    end
  end

  # Shortcut: AllyMailer.client('YOUR_API_KEY')
  # @param host [String, nil] API host, e.g. 'cp.allymailer.com', or a full base URL
  # @param options [Hash] transport:, timeout:, platform:, headers: (see AllyMailerClient#initialize)
  # @return [AllyMailerClient]
  def self.client(api_key, host = nil, **options)
    AllyMailerClient.new(api_key, host, **options)
  end
end
