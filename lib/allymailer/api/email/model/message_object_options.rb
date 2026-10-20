# frozen_string_literal: true

module AllyMailer
  module Api
    module Email
      module Model
        # Додаткові опції.
        class MessageObjectOptions
          # Дата й час у форматі "РРРР-ММ-ДД гг:хх:сс" у часовому поясі UTC. Дозволяє запланувати час надсилання
          # на майбутнє, у межах 24 годин від поточного часу.
          # @return [String, nil]
          attr_accessor :send_at

          # Користувацьке посилання відписки. Докладніше [тут](https://docs.allymailer.com.ua/unsubscribe-link).
          # @return [String, nil]
          attr_accessor :unsubscribe_url

          # Ідентифікатор backend-домену, через який надсилається повідомлення. Якщо відсутній — надсилання буде
          # від імені backend-домену, призначеного вашому обліковому запису/проєкту за замовчуванням. Ви можете
          # придбати один або декілька виділених IP-адрес і використовувати цю опцію для вибору.
          # @return [Integer, nil]
          attr_accessor :custom_backend_id

          # Ідентифікатор пулу SMTP, через який надсилається повідомлення. Зазвичай немає необхідності вказувати
          # пул явно, оскільки він обирається автоматично або як пул за замовчуванням для вашого облікового
          # запису/проєкту, або відповідно до переданого параметра custom_backend_id.
          # @return [String, nil]
          attr_accessor :smtp_pool_id

          def initialize(
            send_at: nil,
            unsubscribe_url: nil,
            custom_backend_id: nil,
            smtp_pool_id: nil
          )
            @send_at = send_at
            @unsubscribe_url = unsubscribe_url
            @custom_backend_id = custom_backend_id
            @smtp_pool_id = smtp_pool_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              send_at: data['send_at'],
              unsubscribe_url: data['unsubscribe_url'],
              custom_backend_id: data['custom_backend_id'],
              smtp_pool_id: data['smtp_pool_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'send_at' => @send_at,
              'unsubscribe_url' => @unsubscribe_url,
              'custom_backend_id' => @custom_backend_id,
              'smtp_pool_id' => @smtp_pool_id,
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
