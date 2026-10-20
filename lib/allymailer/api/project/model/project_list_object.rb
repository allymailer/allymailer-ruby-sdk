# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # ProjectListObject
        class ProjectListObject
          # Унікальний ідентифікатор проєкту, ASCII-рядок до 36 символів завдовжки.
          # @return [String, nil]
          attr_accessor :id

          # API-ключ проєкту. Ви можете використовувати цей ключ замість користувацького api_key у всіх методах,
          # крім project-методів.
          # @return [String, nil]
          attr_accessor :api_key

          # Назва проєкту, унікальна в межах облікового запису користувача.
          # @return [String, nil]
          attr_accessor :name

          # Двобуквений код країни за правилами ISO-3166 alpha-2. Якщо задано, то AllyMailer обробляє
          # персональні дані проєкту відповідно до законів заданої країни — наприклад, відповідно до GDPR для
          # європейських країн.
          # @return [String, nil]
          attr_accessor :country

          # Дата й час створення проєкту в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :reg_time

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

          # Значення лічильника листів для проєкту, збільшується під час надсилання кожного листа.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Дозволяє обмежити кількість надісланих проєктом листів. У разі досягнення цього ліміту надсилання
          # припиняється. Значення 0 (за замовчуванням) означає відсутність ліміту.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # 'default' - лічильник автоматично скидається в нуль на початку кожного облікового періоду,
          # 'permanent' - лічильник ніколи не скидається автоматично.
          # За замовчуванням: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          # Унікальний ідентифікатор, який визначає сторінку відписки за замовчуванням. Якщо відсутній —
          # обліковому запису/проєкту буде призначено системну сторінку відписки за замовчуванням.
          # @return [Integer, nil]
          attr_accessor :unsubscribe_page_id

          def initialize(
            id: nil,
            api_key: nil,
            name: nil,
            country: nil,
            reg_time: nil,
            send_enabled: nil,
            custom_unsubscribe_url_enabled: nil,
            backend_domain_id: nil,
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil,
            unsubscribe_page_id: nil
          )
            @id = id
            @api_key = api_key
            @name = name
            @country = country
            @reg_time = reg_time
            @send_enabled = send_enabled
            @custom_unsubscribe_url_enabled = custom_unsubscribe_url_enabled
            @backend_domain_id = backend_domain_id
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
            @unsubscribe_page_id = unsubscribe_page_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              id: data['id'],
              api_key: data['api_key'],
              name: data['name'],
              country: data['country'],
              reg_time: data['reg_time'],
              send_enabled: data['send_enabled'],
              custom_unsubscribe_url_enabled: data['custom_unsubscribe_url_enabled'],
              backend_domain_id: data['backend_domain_id'],
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode'],
              unsubscribe_page_id: data['unsubscribe_page_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'id' => @id,
              'api_key' => @api_key,
              'name' => @name,
              'country' => @country,
              'reg_time' => @reg_time,
              'send_enabled' => @send_enabled,
              'custom_unsubscribe_url_enabled' => @custom_unsubscribe_url_enabled,
              'backend_domain_id' => @backend_domain_id,
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
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
