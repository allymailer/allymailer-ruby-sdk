# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Tag
      # Методи керування користувацькими мітками. За допомогою міток ви можете класифікувати листи за
      # потрібними критеріями. Відокремити маркетингові листи від транзакційних або листи з підтвердженням
      # реєстрації від сповіщень про замовлення. AllyMailer дозволяє позначати мітками кожне вихідне
      # повідомлення, а потім сегментувати й аналізувати статистику на основі зазначених під час надсилання
      # міток.
      class TagApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Метод без параметрів, повертає список усіх користувацьких міток.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#tag-list
        # @return [::AllyMailer::Api::Tag::Model::TagListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list
          ::AllyMailer::Api::Tag::Model::TagListResponse.from_h(@client.call('/tag/list.json'))
        end

        # Видаляє мітку.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#tag-delete
        # @param request [::AllyMailer::Api::Tag::Model::TagDeleteRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/tag/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
