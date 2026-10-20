# frozen_string_literal: true

module AllyMailer
  module Api
    module Email
      module Model
        # MessageObjectRecipientsItem
        class MessageObjectRecipientsItem
          # Email-адреса отримувача
          # @return [String, nil]
          attr_accessor :email

          # Об'єкт, що описує підстановки для конкретного отримувача (наприклад, ім'я, товар для показу саме
          # цьому отримувачу — див. [Шаблонізатори](https://docs.allymailer.com.ua/en/template-engines)).
          # Підстановки працюють у параметрах:
          #
          # - body.html
          # - body.plaintext
          # - body.amp
          # - subject
          # - from_name
          # - headers["List-Unsubscribe"]
          # - options.unsubscribe_url
          # Назви змінних можуть містити літери латинського алфавіту, цифри, символ "_". Першим символом може
          # бути лише літера, використання пробілів не допускається. Є спеціальна змінна "to_name", що дозволяє
          # задати ім'я отримувача. У разі підстановки туди "Ім'я Прізвище" SMTP-заголовок “To” виглядатиме як
          # "Ім'я Прізвище <email@example.com>". Довжина змінної "to_name" обмежена 78 символами.
          # @return [Hash{String => String}, nil]
          attr_accessor :substitutions

          # Об'єкт для передачі метаданих, специфічних для окремого отримувача, де "key" — рядок до 64 символів
          # завдовжки, "value" — рядок до 1024 символів завдовжки, максимальна кількість ключів — 10. Метадані
          # передаються під час виклику [webhook](https://docs.allymailer.com.ua/ua/web-api-ref#webhook) і
          # методів [event-dump](https://docs.allymailer.com.ua/ua/web-api-ref#event-dump). Для групування
          # листів в одну розсилку може використовуватися системний ключ "campaign_id" зі значенням у вигляді
          # невід'ємного десяткового цілого або UUID до 128 біт.
          # @return [Hash{String => String}, nil]
          attr_accessor :metadata

          def initialize(
            email:,
            substitutions: nil,
            metadata: nil
          )
            @email = email
            @substitutions = substitutions
            @metadata = metadata
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              substitutions: ::AllyMailer::Client::Decode.map(data['substitutions']),
              metadata: ::AllyMailer::Client::Decode.map(data['metadata'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'substitutions' => @substitutions,
              'metadata' => @metadata,
            }.compact
          end

          def to_json(*args)
            to_h.to_json(*args)
          end
        end
      end
    end
  end
end
