# Template

[До списку розділів](../README.md)

Ви можете зберегти шаблон на боці AllyMailer і потім посилатися на нього за ідентифікатором. Це не обов'язково, але вкрай рекомендовано у разі повторюваних email-повідомлень або за великих обсягів надсилання. AllyMailer підтримує два різні синтаксиси для шаблонів, докладніше читайте [тут](https://docs.allymailer.com.ua/ua/template-engines).

`AllyMailer::Api::Template::TemplateApi`, `client.template`

| Метод | Ендпоінт | Опис |
|---|---|---|
| [`set`](#set) | `POST /template/set.json` | Створити або оновити шаблон. |
| [`get`](#get) | `POST /template/get.json` | Повертає властивості шаблону за його ідентифікатором. |
| [`list`](#list) | `POST /template/list.json` | Повертає повний список або частину списку всіх шаблонів. |
| [`delete`](#delete) | `POST /template/delete.json` | Видаляє шаблон за ідентифікатором. |

## set

`POST /template/set.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#template-set)

Створити або оновити шаблон.

Обмеження:
* Максимальний розмір запиту — 10 MB.
* Кількість шаблонів обмежено 10000.

### Запит: `TemplateSetRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `template` | `TemplateObject` | так | Об'єкт, що містить властивості шаблону. |

### Відповідь: `TemplateSetResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `template` | `TemplateObject` | Об'єкт, що містить властивості шаблону. |

### Приклад

```ruby
require 'allymailer'

Common = AllyMailer::Common::Model
Template = AllyMailer::Api::Template::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.template.set(Template::TemplateSetRequest.new(
  template: Template::TemplateObject.new(
    name: 'name',
    editor_type: Template::EditorType::HTML,
    template_engine: Common::TemplateEngine::VELOCITY,
    subject: 'AllyMailer test email ',
    from_email: 'user@example.com',
    from_name: 'John Smith',
    reply_to: 'email@example.com',
    reply_to_name: 'John Smith'
  )
))
p response.template
```

## get

`POST /template/get.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#template-get)

Повертає властивості шаблону за його ідентифікатором.

### Запит: `TemplateGetRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `id` | `String` | так | Ідентифікатор шаблону. |

### Відповідь: `TemplateGetResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `template` | `TemplateObject` | Об'єкт, що містить властивості шаблону. |

### Приклад

```ruby
require 'allymailer'

Template = AllyMailer::Api::Template::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.template.get(Template::TemplateGetRequest.new(
  id: '00000000-0000-0000-0000-000000000000'
))
p response.template
```

## list

`POST /template/list.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#template-list)

Повертає повний список або частину списку всіх шаблонів.

Ви можете переглядати великий список частинами, використовуючи параметри "offset" і "limit". Якщо повернуто менше ніж "limit" шаблонів — значить, ви досягли кінця списку.

### Запит: `TemplateListRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `limit` | `Integer` |  | Максимальна кількість шаблонів, що повертаються, за замовчуванням 50. |
| `offset` | `Integer` |  | Індекс першого шаблону зі списку, що повертається, рахуючи з нуля. |

### Відповідь: `TemplateListResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `templates` | `Array<TemplateListObject>` | Масив об'єктів-шаблонів. |

### Приклад

```ruby
require 'allymailer'

Template = AllyMailer::Api::Template::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.template.list(Template::TemplateListRequest.new)
p response.templates
```

## delete

`POST /template/delete.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#template-delete)

Видаляє шаблон за ідентифікатором.

### Запит: `TemplateDeleteRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `id` | `String` | так | Ідентифікатор шаблону. |

### Відповідь: `SuccessResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |

### Приклад

```ruby
require 'allymailer'

Template = AllyMailer::Api::Template::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.template.delete(Template::TemplateDeleteRequest.new(
  id: '00000000-0000-0000-0000-000000000000'
))
p response
```
