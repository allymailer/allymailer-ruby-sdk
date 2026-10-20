# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Suppression
      # Методи для керування адресами, надсилання на які заблоковано з різних причин — відписка,
      # недоступність, скарги.
      class SuppressionApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Додає email-адресу до списку недоступних. Ви завжди зможете пізніше видалити цю адресу зі списку
        # недоступних методом
        # [suppression/delete](https://docs.allymailer.com.ua/ua/web-api-ref#suppression-delete).
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#suppression-set
        # @param request [::AllyMailer::Api::Suppression::Model::SuppressionSetRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def set(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/suppression/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає причину й дату блокування email-адреси.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#suppression-get
        # @param request [::AllyMailer::Api::Suppression::Model::SuppressionGetRequest, Hash]
        # @return [::AllyMailer::Api::Suppression::Model::SuppressionGetResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def get(request)
          ::AllyMailer::Api::Suppression::Model::SuppressionGetResponse.from_h(@client.call('/suppression/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає список недоступних, починаючи з указаної дати.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#suppression-list
        # @param request [::AllyMailer::Api::Suppression::Model::SuppressionListRequest, Hash]
        # @return [::AllyMailer::Api::Suppression::Model::SuppressionListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list(request)
          ::AllyMailer::Api::Suppression::Model::SuppressionListResponse.from_h(@client.call('/suppression/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Видаляє email-адресу зі списку недоступних (лише записи з is_deletable=true). Якщо жодного запису
        # для email не знайдено, повертається помилка API 3003. Якщо записи про недоступність знайдено, але
        # жодну з них видалити не можна, повертається помилка API 3004. Якщо перевищено ліміт видалень на
        # добу, повертається помилка API 906.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#suppression-delete
        # @param request [::AllyMailer::Api::Suppression::Model::SuppressionDeleteRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/suppression/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
