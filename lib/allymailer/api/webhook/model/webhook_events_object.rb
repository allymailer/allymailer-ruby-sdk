# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Об'єкт, що описує події, про які потрібно сповіщати.
        class WebhookEventsObject
          # Якщо присутній, то надсилатимуться сповіщення про спам-блокування. У масиві має бути єдиний елемент
          # із рядком "*".
          # @return [Array<String>, nil]
          attr_accessor :spam_block

          # Якщо присутній, то надсилатимуться сповіщення про зміну статусу email. У масиві перелічуються ті
          # статуси, про які надсилатимуться сповіщення.
          # @return [Array<EmailStatus>, nil]
          attr_accessor :email_status

          def initialize(
            spam_block: nil,
            email_status: nil
          )
            @spam_block = spam_block
            @email_status = email_status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              spam_block: ::AllyMailer::Client::Decode.list(data['spam_block']),
              email_status: ::AllyMailer::Client::Decode.list(data['email_status'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'spam_block' => @spam_block,
              'email_status' => @email_status,
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
