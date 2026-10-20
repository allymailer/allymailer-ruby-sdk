# frozen_string_literal: true

module AllyMailer
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedSetResponse
        class ObsoleteUnsubscribedSetResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Відписаний email.
          # @return [String, nil]
          attr_accessor :address

          # Подробиці відписки:
          #
          # - "unsubscribed" якщо email було щойно відписано,
          # - "was inactive" якщо він уже був позначений як неактивний і немає сенсу відписувати,
          # - "was unsubscribed" якщо email уже було відписано раніше,
          # - "added and unsubscribed" якщо для цього email не зберігалося жодного більш раннього статусу, тому його було додано й одразу ж відписано.
          # @return [ObsoleteUnsubscribedSetMessage, nil]
          attr_accessor :message

          def initialize(
            status: nil,
            address: nil,
            message: nil
          )
            @status = status
            @address = address
            @message = message
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              address: data['address'],
              message: data['message']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'address' => @address,
              'message' => @message,
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
