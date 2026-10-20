# frozen_string_literal: true

module AllyMailer
  module Api
    module ConfirmedEmail
      module Model
        # ConfirmedEmailCreateResponse
        class ConfirmedEmailCreateResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # @return [ConfirmedEmail, nil]
          attr_accessor :confirmed_email

          def initialize(
            status: nil,
            confirmed_email: nil
          )
            @status = status
            @confirmed_email = confirmed_email
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              confirmed_email: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::ConfirmedEmail::Model::ConfirmedEmail, data['confirmed_email'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'confirmed_email' => @confirmed_email.nil? ? nil : @confirmed_email.to_h,
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
