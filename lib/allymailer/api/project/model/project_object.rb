# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # Об'єкт із властивостями проєкту.
        class ProjectObject
          # Назва проєкту, унікальна в межах облікового запису користувача.
          # @return [String, nil]
          attr_accessor :name

          # Двобуквений код країни за правилами ISO-3166 alpha-2. Якщо задано, то AllyMailer обробляє
          # персональні дані проєкту відповідно до законів заданої країни — наприклад, відповідно до GDPR для
          # європейських країн.
          # @return [String, nil]
          attr_accessor :country

          # Чи дозволено надсилання листів для проєкту.
          # За замовчуванням: `True`.
          # @return [Boolean, nil]
          attr_accessor :send_enabled

          # Якщо false, то AllyMailer додає в кінець кожного листа системне посилання відписки. Значення true
          # вимикає автоматичне додавання системою посилання відписки в кінець листа й дозволяє використовувати
          # власне посилання відписки або надсилати листи зовсім без посилання відписки. Докладніше див.
          # [тут](https://docs.allymailer.com.ua/ua/unsubscribe-link). Якщо ви не вказуєте значення
          # custom_unsubscribe_url_enabled під час створення проєкту — то це значення копіюється з головного
          # облікового запису (якщо в головному обліковому записі було встановлено примусове вимкнення посилання
          # відписки — то й у проєкту посилання відписки буде вимкнено).
          # @return [Boolean, nil]
          attr_accessor :custom_unsubscribe_url_enabled

          # Унікальний ідентифікатор backend-домену, який визначає [домен посилань](/tracking-domains) або пул
          # [виділених IP-адрес](/dedicated-ip) за замовчуванням. Якщо відсутній — обліковому запису/проєкту
          # буде призначено дефолтний backend-домен за замовчуванням.
          # @return [Integer, nil]
          attr_accessor :backend_domain_id

          # Унікальний ідентифікатор, який визначає сторінку відписки за замовчуванням. Якщо відсутній —
          # обліковому запису/проєкту буде призначено системну сторінку відписки за замовчуванням.
          # @return [Integer, nil]
          attr_accessor :unsubscribe_page_id

          def initialize(
            name:,
            country: nil,
            send_enabled: nil,
            custom_unsubscribe_url_enabled: nil,
            backend_domain_id: nil,
            unsubscribe_page_id: nil
          )
            @name = name
            @country = country
            @send_enabled = send_enabled
            @custom_unsubscribe_url_enabled = custom_unsubscribe_url_enabled
            @backend_domain_id = backend_domain_id
            @unsubscribe_page_id = unsubscribe_page_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              name: data['name'],
              country: data['country'],
              send_enabled: data['send_enabled'],
              custom_unsubscribe_url_enabled: data['custom_unsubscribe_url_enabled'],
              backend_domain_id: data['backend_domain_id'],
              unsubscribe_page_id: data['unsubscribe_page_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'name' => @name,
              'country' => @country,
              'send_enabled' => @send_enabled,
              'custom_unsubscribe_url_enabled' => @custom_unsubscribe_url_enabled,
              'backend_domain_id' => @backend_domain_id,
              'unsubscribe_page_id' => @unsubscribe_page_id,
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
