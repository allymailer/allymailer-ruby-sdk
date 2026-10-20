# Tag

[До списку розділів](../README.md)

Методи керування користувацькими мітками. За допомогою міток ви можете класифікувати листи за потрібними критеріями. Відокремити маркетингові листи від транзакційних або листи з підтвердженням реєстрації від сповіщень про замовлення. AllyMailer дозволяє позначати мітками кожне вихідне повідомлення, а потім сегментувати й аналізувати статистику на основі зазначених під час надсилання міток.

`AllyMailer::Api::Tag::TagApi`, `client.tag`

| Метод | Ендпоінт | Опис |
|---|---|---|
| [`list`](#list) | `POST /tag/list.json` | Метод без параметрів, повертає список усіх користувацьких міток. |
| [`delete`](#delete) | `POST /tag/delete.json` | Видаляє мітку. |

## list

`POST /tag/list.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#tag-list)

Метод без параметрів, повертає список усіх користувацьких міток.

### Запит

Метод не має параметрів.

### Відповідь: `TagListResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |
| `tags` | `Array<TagsResponseObject>` | Масив об'єктів з даними користувацьких міток. |

### Приклад

```ruby
require 'allymailer'

client = AllyMailer.client('YOUR_API_KEY')

response = client.tag.list
p response.tags
```

## delete

`POST /tag/delete.json` · [Документація](https://docs.allymailer.com.ua/ua/web-api-ref#tag-delete)

Видаляє мітку.

### Запит: `TagDeleteRequest`

| Поле | Тип | Обов'язкове | Опис |
|---|---|---|---|
| `tag_id` | `Integer` | так | Унікальний id мітки. |

### Відповідь: `SuccessResponse`

| Поле | Тип | Опис |
|---|---|---|
| `status` | `String` | Рядок "success". (`success`) |

### Приклад

```ruby
require 'allymailer'

Tag = AllyMailer::Api::Tag::Model

client = AllyMailer.client('YOUR_API_KEY')

response = client.tag.delete(Tag::TagDeleteRequest.new(
  tag_id: 54
))
p response
```
