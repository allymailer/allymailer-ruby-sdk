# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module System
      # Системні методи.
      class SystemApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Перевіряє валідність API-ключа та повертає ідентифікатор користувача.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#system-ping
        # @return [::AllyMailer::Api::System::Model::SystemPingResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def ping
          ::AllyMailer::Api::System::Model::SystemPingResponse.from_h(@client.call('/system/ping.json'))
        end

        # Повертає інформацію про користувача або проєкт за API-ключем.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#system-info
        # @return [::AllyMailer::Api::System::Model::SystemInfoResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def info
          ::AllyMailer::Api::System::Model::SystemInfoResponse.from_h(@client.call('/system/info.json'))
        end
      end
    end
  end
end
