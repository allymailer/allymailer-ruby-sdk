# ConfirmedEmail

[До списку розділів](../README.md)

Керування email-адресами, підтвердженими для надсилання із sandbox-домену. Методи доступні лише з API-ключем основного облікового запису.

`AllyMailer::Api::ConfirmedEmail::ConfirmedEmailApi`, `client.confirmed_email`

| Метод | Ендпоінт | Опис |
|---|---|---|
| [`create`](#create) | `POST /confirmed-email/create.json` | Adds an email address and sends a confirmation link. |
| [`list`](#list) | `POST /confirmed-email/list.json` | Lists confirmed and unconfirmed email addresses for the account. |
| [`delete`](#delete) | `POST /confirmed-email/delete.json` | Deletes an email address from the account's confirmed email list. |

## create

`POST /confirmed-email/create.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-create)

Adds an email address and sends a confirmation link.

### Запит: `ConfirmedEmailRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `email` | `String` | так | Email address to add or delete. |

### Відповідь: `ConfirmedEmailCreateResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `confirmed_email` | `ConfirmedEmail` |  |

### Приклад

```ruby
require 'allymailer'

ConfirmedEmail = AllyMailer::Api::ConfirmedEmail::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.confirmed_email.create(ConfirmedEmail::ConfirmedEmailRequest.new(
  email: 'dev@example.com'
))
p response.confirmed_email
```

## list

`POST /confirmed-email/list.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-list)

Lists confirmed and unconfirmed email addresses for the account.

### Запит

Метод не має параметрів.

### Відповідь: `ConfirmedEmailListResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `confirmed_emails` | `Array<ConfirmedEmail>` |  |

### Приклад

```ruby
require 'allymailer'

client = AllyMailer.client('YOUR_API_KEY')

response = client.confirmed_email.list
p response.confirmed_emails
```

## delete

`POST /confirmed-email/delete.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-delete)

Deletes an email address from the account's confirmed email list.

### Запит: `ConfirmedEmailRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `email` | `String` | так | Email address to add or delete. |

### Відповідь: `ConfirmedEmailDeleteResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `message` | `String` |  |

### Приклад

```ruby
require 'allymailer'

ConfirmedEmail = AllyMailer::Api::ConfirmedEmail::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.confirmed_email.delete(ConfirmedEmail::ConfirmedEmailRequest.new(
  email: 'dev@example.com'
))
p response.message
```
