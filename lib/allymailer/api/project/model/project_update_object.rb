# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # Об'єкт із властивостями проєкту.
        class ProjectUpdateObject
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
          # [тут](https://docs.allymailer.com.ua/en/unsubscribe-link). Якщо ви не вказуєте значення
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

          # Значення лічильника листів для проєкту, збільшується під час надсилання кожного листа. Приймає лише
          # значення 0 (тобто скидання лічильника в нуль) або оновлюється автоматично, залежно від режиму роботи
          # лічильника, заданого параметром 'email_counter_mode'. Якщо поле не передано в запиті або передано
          # null, то значення лічильника не змінюється.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Дозволяє обмежити кількість надісланих проєктом листів. У разі досягнення цього ліміту надсилання
          # припиняється. Приймається будь-яке невід'ємне 64-бітне ціле число. Значення 0 означає відсутність
          # ліміту. Якщо поле не передано в запиті або передано null, то значення ліміту не змінюється.
          # За замовчуванням: `0`.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # Встановлює режим роботи лічильника листів. Дозволяє вибрати, як має поводитися лічильник:
          # автоматично скидатися чи залишатися постійним. Припустимі значення: default - лічильник автоматично
          # скидається в нуль на початку кожного облікового періоду, permanent - лічильник ніколи не скидається
          # автоматично. Скидання може бути виконане лише вручну користувачем, передавши значення 0 у полі
          # 'email_counter'. Якщо поле не передано в запиті або передано значення null, значення режиму не
          # змінюється.
          # За замовчуванням: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          def initialize(
            name:,
            country: nil,
            send_enabled: nil,
            custom_unsubscribe_url_enabled: nil,
            backend_domain_id: nil,
            unsubscribe_page_id: nil,
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil
          )
            @name = name
            @country = country
            @send_enabled = send_enabled
            @custom_unsubscribe_url_enabled = custom_unsubscribe_url_enabled
            @backend_domain_id = backend_domain_id
            @unsubscribe_page_id = unsubscribe_page_id
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
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
              unsubscribe_page_id: data['unsubscribe_page_id'],
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode']
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
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
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
