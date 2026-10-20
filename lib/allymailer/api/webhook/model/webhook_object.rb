# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Об'єкт з усіма властивостями webhook.
        class WebhookObject
          # Унікальний ідентифікатор webhook.
          # @return [Integer, nil]
          attr_accessor :id

          # URL webhook.
          # @return [String, nil]
          attr_accessor :url

          # Статус webhook, за замовчуванням "active". Статус "disabled" означає, що webhook було вимкнено
          # користувачем, "stopped" означає, що webhook було зупинено системою після 24 годин невдалих викликів
          # (мінімум за 10 різними подіями).
          # За замовчуванням: `active`.
          # @return [WebhookStatus, nil]
          attr_accessor :status

          # Формат сповіщень. "json_post"(за замовчуванням) або "json_post_gzip".
          # За замовчуванням: `json_post`.
          # @return [WebhookEventFormat, nil]
          attr_accessor :event_format

          # Повертати (1) чи ні (0) докладну інформацію про доставку. Якщо delivery_info=1, повертається
          # додаткова інформація про відповідь сервера та внутрішній статус доставки в разі статусів доставки
          # "hard_bounced" і "soft_bounced"; user agent, IP-адреса отримувача, геодані, визначена за user agent
          # інформація про пристрій (тип і марка пристрою, назва ОС, браузера або поштового клієнта) і
          # traffic_type (human, machine, protected або unknown) в разі статусів "opened" і "clicked"; URL для
          # статусу "clicked". Для статусів "delivered", "soft_bounced" і "hard_bounced" AllyMailer також може
          # повернути sender_ip — IP-адресу SMTP-сервера, з якого було надіслано лист, якщо він доступний.
          # Допустимі значення: `0`, `1`.
          # За замовчуванням: `0`.
          # @return [Integer, nil]
          attr_accessor :delivery_info

          # 0=в одному виклику може надійти декілька подій, 1=лише одна подія на виклик (не рекомендується).
          # Допустимі значення: `0`, `1`.
          # За замовчуванням: `0`.
          # @return [Integer, nil]
          attr_accessor :single_event

          # Максимальна кількість дозволених паралельних запитів до вашого сервера. Чим більше ваш сервер може
          # обробити — тим краще.
          # За замовчуванням: `10`.
          # @return [Integer, nil]
          attr_accessor :max_parallel

          # Час останнього оновлення властивостей webhook у часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :updated_at

          # Об'єкт, що описує події, про які потрібно сповіщати.
          # @return [WebhookEventsObject, nil]
          attr_accessor :events

          def initialize(
            id: nil,
            url: nil,
            status: nil,
            event_format: nil,
            delivery_info: nil,
            single_event: nil,
            max_parallel: nil,
            updated_at: nil,
            events: nil
          )
            @id = id
            @url = url
            @status = status
            @event_format = event_format
            @delivery_info = delivery_info
            @single_event = single_event
            @max_parallel = max_parallel
            @updated_at = updated_at
            @events = events
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              id: data['id'],
              url: data['url'],
              status: data['status'],
              event_format: data['event_format'],
              delivery_info: data['delivery_info'],
              single_event: data['single_event'],
              max_parallel: data['max_parallel'],
              updated_at: data['updated_at'],
              events: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Webhook::Model::WebhookEventsObject, data['events'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'id' => @id,
              'url' => @url,
              'status' => @status,
              'event_format' => @event_format,
              'delivery_info' => @delivery_info,
              'single_event' => @single_event,
              'max_parallel' => @max_parallel,
              'updated_at' => @updated_at,
              'events' => @events.nil? ? nil : @events.to_h,
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
