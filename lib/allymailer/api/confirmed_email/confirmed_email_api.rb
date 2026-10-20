# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module ConfirmedEmail
      # Керування email-адресами, підтвердженими для надсилання із sandbox-домену. Методи доступні лише з
      # API-ключем основного облікового запису.
      class ConfirmedEmailApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Adds an email address and sends a confirmation link.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-create
        # @param request [::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailRequest, Hash]
        # @return [::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailCreateResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def create(request)
          ::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailCreateResponse.from_h(@client.call('/confirmed-email/create.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Lists confirmed and unconfirmed email addresses for the account.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-list
        # @return [::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list
          ::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailListResponse.from_h(@client.call('/confirmed-email/list.json'))
        end

        # Deletes an email address from the account's confirmed email list.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#confirmed-email-delete
        # @param request [::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailRequest, Hash]
        # @return [::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailDeleteResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmailDeleteResponse.from_h(@client.call('/confirmed-email/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
