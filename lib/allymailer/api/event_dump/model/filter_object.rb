# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # Об'єкт із властивостями фільтра дампа подій.
        class FilterObject
          # Ідентифікатор завдання, раніше повернутий методом
          # [email/send](https://docs.allymailer.com.ua/ua/web-api-ref#email-send).
          # @return [String, nil]
          attr_accessor :job_id

          # Статус email. Можна вказати одне з таких значень:
          #
          # __accepted__ — повідомлення прийнято, але ще не надіслано.
          #
          # __sent__ — повідомлення надіслано, але ще не доставлено.
          #
          # __delivered__ — повідомлення доставлено.
          #
          # __opened__ — повідомлення доставлено й зареєстровано його прочитання.
          #
          # __clicked__ — повідомлення доставлено, прочитано, було зареєстровано перехід за одним з посилань у
          # листі.
          #
          # __unsubscribed__ — повідомлення було доставлено отримувачу й прочитано ним, але користувач
          # відписався за посиланням у листі.
          #
          # __subscribed__ — повідомлення було доставлено отримувачу й прочитано ним, але користувач відписався,
          # а потім знову підписався за посиланням у листі.
          #
          # __soft_bounced__ — тимчасова недоставка повідомлення. AllyMailer продовжує спроби доставки протягом
          # 2 діб.
          #
          # __hard_bounced__ — доставка не вдалася, спроб доставки більше не буде.
          #
          # __spam__ — повідомлення доставлено, але позначено як “спам” отримувачем.
          # @return [EmailStatus, nil]
          attr_accessor :status

          # Внутрішній детальний статус доставки AllyMailer. Можна вказати декілька статусів через кому. Ось
          # деякі з можливих статусів:
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

          # Адреса отримувача
          # @return [String, nil]
          attr_accessor :email

          # Адреса відправника
          # @return [String, nil]
          attr_accessor :email_from

          # Домен отримувача
          # @return [String, nil]
          attr_accessor :domain

          # Ідентифікатор розсилки, невід'ємне десяткове ціле або UUID до 128 біт, передане в метаданих у полі з
          # іменем "campaign_id" (ім'я можна налаштувати через техпідтримку).
          # @return [String, nil]
          attr_accessor :campaign_id

          def initialize(
            job_id: nil,
            status: nil,
            delivery_status: nil,
            email: nil,
            email_from: nil,
            domain: nil,
            campaign_id: nil
          )
            @job_id = job_id
            @status = status
            @delivery_status = delivery_status
            @email = email
            @email_from = email_from
            @domain = domain
            @campaign_id = campaign_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              job_id: data['job_id'],
              status: data['status'],
              delivery_status: data['delivery_status'],
              email: data['email'],
              email_from: data['email_from'],
              domain: data['domain'],
              campaign_id: data['campaign_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'job_id' => @job_id,
              'status' => @status,
              'delivery_status' => @delivery_status,
              'email' => @email,
              'email_from' => @email_from,
              'domain' => @domain,
              'campaign_id' => @campaign_id,
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
