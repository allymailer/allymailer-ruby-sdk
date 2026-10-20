# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Об'єкт з різними властивостями події, що залежать від поля "event_name". Нижче перелічено всі
        # можливі властивості, спочатку для події "transactional_email_status", потім для події
        # "transactional_spam_block".
        class WebhookCallbackEventsByUserItemEventsItemEventData
          # Ідентифікатор завдання, раніше повернутий методом
          # [email/send](https://docs.allymailer.com.ua/ua/web-api-ref#email-send). Присутній лише якщо
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :job_id

          # Метадані, раніше передані методом
          # [email/send](https://docs.allymailer.com.ua/ua/web-api-ref#email-send) у полі recipients.metadata
          # або global_metadata. Присутні лише якщо event_name="transactional_email_status".
          # @return [Hash{String => String}, nil]
          attr_accessor :metadata

          # Email, на який було здійснено надсилання. Присутній лише якщо
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :email

          # Статус доставки листа. Присутній лише якщо event_name="transactional_email_status". Набуває одного з
          # таких значень:
          #
          # __accepted__ — повідомлення прийнято, але ще не надіслано.
          #
          # __sent__ — повідомлення надіслано, але ще не доставлено.
          #
          # __delivered__ — повідомлення доставлено. Може змінитися на “opened”, “clicked”, “unsubscribed”,
          # “subscribed” або “spam”.
          #
          # __opened__ — повідомлення доставлено й зареєстровано його прочитання. Може змінитися на “clicked”,
          # “unsubscribed”, “subscribed” або “spam”.
          #
          # __clicked__ — повідомлення доставлено, прочитано, було зареєстровано перехід за одним з посилань у
          # листі. Може змінитися на “unsubscribed”, “subscribed” або “spam”.
          #
          # __unsubscribed__ — повідомлення було доставлено отримувачу й прочитано ним, але користувач
          # відписався за посиланням у листі. Може змінитися на “subscribed”.
          #
          # __subscribed__ — повідомлення було доставлено отримувачу й прочитано ним, але користувач відписався,
          # а потім знову підписався за посиланням у листі. Може змінитися на “unsubscribed”.
          #
          # __soft_bounced__ — тимчасова недоставка повідомлення. AllyMailer продовжує спроби доставки протягом
          # 2 діб. У разі успішної доставки лист перейде у статус “delivered”, у разі неуспішної — у
          # “hard_bounced”.
          #
          # __hard_bounced__ — доставка не вдалася, спроб доставки більше не буде. Статус остаточний. Можливих
          # причин невдалої доставки безліч, для їх аналізу можна використати текст відповіді SMTP-сервера з
          # поля delivery_info.destination_response або нашу внутрішню класифікацію помилок з поля
          # delivery_info.delivery_status.
          #
          # __spam__ — повідомлення доставлено, але позначено як “спам” отримувачем. Статус остаточний. Ось
          # деякі домени, від яких AllyMailer може отримати й обробити скаргу про спам (використовуючи
          # технологію FBL): mail.ru, msn.com, outlook.com, hotmail.com, live.com, ukr.net, yahoo.com, aol.com.
          # @return [EmailStatus, nil]
          attr_accessor :status

          # Дата й час події в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс". Присутній лише якщо
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :event_time

          # URL у разі статусів "opened" і "clicked". Присутній лише якщо
          # event_name="transactional_email_status".
          # @return [String, nil]
          attr_accessor :url

          # Об'єкт з додатковою інформацією про доставку. Присутній лише якщо властивість delivery_info під час
          # встановлення webhook дорівнювала 1 і якщо event_name="transactional_email_status".
          # @return [WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo, nil]
          attr_accessor :delivery_info

          # Дата й час спам-блока в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс". Присутній лише якщо
          # event_name="transactional_spam_block".
          # @return [String, nil]
          attr_accessor :block_time

          # Тип спам-блока — заблоковано або один відправляючий SMTP, або одразу багато. У разі блокування
          # одиночного SMTP із загального пулу AllyMailer пробуватиме ще декілька. Властивість присутня лише
          # якщо event_name="transactional_spam_block".
          # @return [BlockType, nil]
          attr_accessor :block_type

          # Домен, що заблокував надсилання. Властивість присутня лише якщо
          # event_name="transactional_spam_block".
          # @return [String, nil]
          attr_accessor :domain

          # Кількість заблокованих вихідних SMTP. Властивість присутня лише якщо
          # event_name="transactional_spam_block".
          # @return [Integer, nil]
          attr_accessor :smtp_blocks_count

          # Це подія блокування чи розблокування. Властивість присутня лише якщо
          # event_name="transactional_spam_block".
          # @return [DomainStatus, nil]
          attr_accessor :domain_status

          def initialize(
            job_id: nil,
            metadata: nil,
            email: nil,
            status: nil,
            event_time: nil,
            url: nil,
            delivery_info: nil,
            block_time: nil,
            block_type: nil,
            domain: nil,
            smtp_blocks_count: nil,
            domain_status: nil
          )
            @job_id = job_id
            @metadata = metadata
            @email = email
            @status = status
            @event_time = event_time
            @url = url
            @delivery_info = delivery_info
            @block_time = block_time
            @block_type = block_type
            @domain = domain
            @smtp_blocks_count = smtp_blocks_count
            @domain_status = domain_status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              job_id: data['job_id'],
              metadata: ::AllyMailer::Client::Decode.map(data['metadata']),
              email: data['email'],
              status: data['status'],
              event_time: data['event_time'],
              url: data['url'],
              delivery_info: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Webhook::Model::WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo, data['delivery_info']),
              block_time: data['block_time'],
              block_type: data['block_type'],
              domain: data['domain'],
              smtp_blocks_count: data['SMTP_blocks_count'],
              domain_status: data['domain_status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'job_id' => @job_id,
              'metadata' => @metadata,
              'email' => @email,
              'status' => @status,
              'event_time' => @event_time,
              'url' => @url,
              'delivery_info' => @delivery_info.nil? ? nil : @delivery_info.to_h,
              'block_time' => @block_time,
              'block_type' => @block_type,
              'domain' => @domain,
              'SMTP_blocks_count' => @smtp_blocks_count,
              'domain_status' => @domain_status,
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
