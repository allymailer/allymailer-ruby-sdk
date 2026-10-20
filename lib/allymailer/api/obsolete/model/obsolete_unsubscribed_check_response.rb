# frozen_string_literal: true

module AllyMailer
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedCheckResponse
        class ObsoleteUnsubscribedCheckResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Email, який було перевірено.
          # @return [String, nil]
          attr_accessor :address

          # true якщо відписано, false якщо ні.
          # @return [Boolean, nil]
          attr_accessor :is_unsubscribed

          def initialize(
            status: nil,
            address: nil,
            is_unsubscribed: nil
          )
            @status = status
            @address = address
            @is_unsubscribed = is_unsubscribed
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              address: data['address'],
              is_unsubscribed: data['is_unsubscribed']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'address' => @address,
              'is_unsubscribed' => @is_unsubscribed,
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
