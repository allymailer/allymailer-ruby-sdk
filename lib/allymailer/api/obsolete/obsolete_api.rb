# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Obsolete
      # Застарілі методи роботи з відписками. Ми рекомендуємо користуватися замість них гнучкішими методами
      # [suppression](https://docs.allymailer.com.ua/ua/web-api-ref#suppression). Зверніть увагу, що знову
      # підписати відписаного адресата через WebAPI не можна. Можна лише надіслати йому email із посиланням
      # повторної підписки за допомогою методу email/subscribe.
      class ObsoleteApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Внести email до списку відписаних.
        #
        # Після внесення email до списку відписаних усі майбутні спроби надіслати на нього повідомлення будуть
        # відхилятися. Зауважте, що видалити email зі списку відписаних безпосередньо за допомогою API не
        # можна. Але можна надіслати йому повідомлення з посиланням повторної підписки за допомогою методу
        # [email/subscribe](https://docs.allymailer.com.ua/ua/web-api-ref#email-subscribe) або видалити його
        # зі списку відписаних вручну на сторінці [Пошук email](https://cp.allymailer.com/ua/user/email) у
        # панелі керування (але кількість таких видалень на день сильно обмежена).
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#unsubscribed-set
        # @param request [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedSetRequest, Hash]
        # @return [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedSetResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def unsubscribed_set(request)
          ::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedSetResponse.from_h(@client.call('/unsubscribed/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Перевіряє, чи відписано email.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#unsubscribed-check
        # @param request [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedCheckRequest, Hash]
        # @return [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedCheckResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def unsubscribed_check(request)
          ::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedCheckResponse.from_h(@client.call('/unsubscribed/check.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає список адрес, відписаних починаючи з указаної дати.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#unsubscribed-list
        # @param request [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedListRequest, Hash]
        # @return [::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def unsubscribed_list(request)
          ::AllyMailer::Api::Obsolete::Model::ObsoleteUnsubscribedListResponse.from_h(@client.call('/unsubscribed/list.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
