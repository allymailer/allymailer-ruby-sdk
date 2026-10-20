# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Об'єкт з додатковою інформацією про доставку. Присутній лише якщо властивість delivery_info під час
        # встановлення webhook дорівнювала 1 і якщо event_name="transactional_email_status".
        class WebhookCallbackEventsByUserItemEventsItemEventDataDeliveryInfo
          # Внутрішній детальний статус доставки AllyMailer. Ось деякі з можливих статусів:
          #
          # __err_user_unknown__ -- адреса не існує (і невідомо, чи існувала колись);
          #
          # __err_user_inactive__ -- адреса не використовується;
          #
          # __err_will_retry__ -- лист було тимчасово відхилено, пізніше буде здійснено повторну спробу
          # доставки;
          #
          # __err_mailbox_discarded__ -- адресу видалено (тобто колись існувала, але тепер її немає);
          #
          # __err_mailbox_full__ -- поштова скринька переповнена;
          #
          # __err_spam_rejected__ -- лист відхилено як спам;
          #
          # __err_blacklisted__ -- лист було відхилено через наявність IP-адреси або домену відправника в
          # якомусь із чорних списків;
          #
          # __err_too_large__ -- на думку сервера отримувача, лист перевищує допустимий розмір;
          #
          # __err_unsubscribed__ -- адресат раніше відписався від ваших розсилок;
          #
          # __err_unreachable__ -- адресу позначено як постійно недоступну через багаторазові помилки доставки
          # на цю адресу;
          #
          # __err_skip_letter__ -- надсилання скасовано, оскільки email-адреса тимчасово недоступна;
          #
          # __err_domain_inactive__ -- домен не приймає пошту або не існує;
          #
          # __err_destination_misconfigured__ -- домен не приймає пошту через неправильне налаштування на боці
          # отримувача, причому відповідь сервера містить інформацію про усувну причину (наприклад,
          # використовується непрацюючий блеклист тощо);
          #
          # __err_delivery_failed__ -- доставка не вдалася з інших причин;
          #
          # __err_spam_skipped__ -- надсилання скасовано через блокування розсилки як спаму;
          #
          # __err_lost__ -- лист не було надіслано через неузгодженість його частин, або його було втрачено
          # через збій на нашому боці. Відправник має повторно надіслати лист самостійно, оскільки оригінал не
          # зберігся;
          #
          # Ми залишаємо за собою право змінювати й додавати внутрішні статуси, тому решту
          # використовуваних наразі статусів перелічимо лише довідково, без пояснень:
          # ok_accepted, ok_sent, ok_delivered, ok_read, ok_link_visited, ok_unsubscribed, ok_resubscribed,
          # ok_spam_folder, ok_fbl,
          # not_sent, skip_dup_unreachable, skip_dup_temp_unreachable, skip_dup_mailbox_full,
          # err_spam_removed, err_resend, err_unknown, err_retry_letter, err_src_invalid,
          # err_dest_invalid, err_not_available, err_internal, err_no_dns, err_no_smtp, err_giveup.
          # @return [String, nil]
          attr_accessor :delivery_status

          # Відповідь SMTP-сервера.
          # @return [String, nil]
          attr_accessor :destination_response

          # Рядок user agent отримувача. Присутній лише якщо вдалося його визначити, для статусів "clicked" і
          # "opened".
          # @return [String, nil]
          attr_accessor :user_agent

          # Тип пристрою отримувача, визначений за user agent. Присутній для статусів "clicked" і "opened";
          # дорівнює "unknown", якщо тип пристрою визначити не вдалося.
          # @return [DeviceType, nil]
          attr_accessor :device_type

          # Марка пристрою отримувача, визначена за user agent. Присутня для статусів "clicked" і "opened", якщо
          # її вдалося визначити. Для device_type "mobile" і "tablet" присутня завжди та дорівнює "unknown",
          # якщо марку визначити не вдалося.
          # @return [String, nil]
          attr_accessor :device_brand

          # Назва операційної системи пристрою отримувача, визначена за user agent. Присутня для статусів
          # "clicked" і "opened"; дорівнює "unknown", якщо ОС визначити не вдалося.
          # @return [String, nil]
          attr_accessor :os_name

          # Назва браузера, у якому було відкрито лист, визначена за user agent. Присутня для статусів "clicked"
          # і "opened", лише якщо було визначено браузер, тому ніколи не надходить разом з email_client_name.
          # @return [String, nil]
          attr_accessor :browser_name

          # Назва поштового клієнта, у якому було відкрито лист, визначена за user agent. Присутня для статусів
          # "clicked" і "opened", лише якщо було визначено поштовий клієнт, тому ніколи не надходить разом з
          # browser_name.
          # @return [String, nil]
          attr_accessor :email_client_name

          # Якість трафіку для статусів "opened" і "clicked". "human" — розпізнано звичайний браузер або
          # поштовий клієнт без машинних ознак; "machine" — бот, сканер посилань або проксі безпеки; "protected"
          # — механізм приватності скриньки/ОС, участь людини підтвердити не можна (Apple Mail Privacy
          # Protection / iCloud Private Relay, Gmail Image Proxy; Apple MPP — це protected, не machine);
          # "unknown" — User-Agent відсутній, пошкоджений або не розпізнаний.
          # @return [TrafficType, nil]
          attr_accessor :traffic_type

          # IP-адреса отримувача. Присутня лише якщо вдалося її визначити, для статусів "clicked" і "opened".
          # @return [String, nil]
          attr_accessor :ip

          # ISO 3166-1 alpha-2 код країни, визначений за IP-адресою отримувача. Присутній для статусів "clicked"
          # і "opened".
          # @return [String, nil]
          attr_accessor :country_code

          # Країна, визначена за IP-адресою отримувача. Присутня для статусів "clicked" і "opened".
          # @return [String, nil]
          attr_accessor :country

          # Місто, визначене за IP-адресою отримувача. Присутнє для статусів "clicked" і "opened".
          # @return [String, nil]
          attr_accessor :city

          # IP-адреса SMTP-сервера, з якого було надіслано лист. Присутня лише для статусів "delivered",
          # "soft_bounced" і "hard_bounced", якщо доступна.
          # @return [String, nil]
          attr_accessor :sender_ip

          def initialize(
            delivery_status: nil,
            destination_response: nil,
            user_agent: nil,
            device_type: nil,
            device_brand: nil,
            os_name: nil,
            browser_name: nil,
            email_client_name: nil,
            traffic_type: nil,
            ip: nil,
            country_code: nil,
            country: nil,
            city: nil,
            sender_ip: nil
          )
            @delivery_status = delivery_status
            @destination_response = destination_response
            @user_agent = user_agent
            @device_type = device_type
            @device_brand = device_brand
            @os_name = os_name
            @browser_name = browser_name
            @email_client_name = email_client_name
            @traffic_type = traffic_type
            @ip = ip
            @country_code = country_code
            @country = country
            @city = city
            @sender_ip = sender_ip
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              delivery_status: data['delivery_status'],
              destination_response: data['destination_response'],
              user_agent: data['user_agent'],
              device_type: data['device_type'],
              device_brand: data['device_brand'],
              os_name: data['os_name'],
              browser_name: data['browser_name'],
              email_client_name: data['email_client_name'],
              traffic_type: data['traffic_type'],
              ip: data['ip'],
              country_code: data['country_code'],
              country: data['country'],
              city: data['city'],
              sender_ip: data['sender_ip']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'delivery_status' => @delivery_status,
              'destination_response' => @destination_response,
              'user_agent' => @user_agent,
              'device_type' => @device_type,
              'device_brand' => @device_brand,
              'os_name' => @os_name,
              'browser_name' => @browser_name,
              'email_client_name' => @email_client_name,
              'traffic_type' => @traffic_type,
              'ip' => @ip,
              'country_code' => @country_code,
              'country' => @country,
              'city' => @city,
              'sender_ip' => @sender_ip,
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
