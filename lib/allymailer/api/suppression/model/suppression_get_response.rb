# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # SuppressionGetResponse
        class SuppressionGetResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Email-адреса, для якої було запитано дані про недоступність.
          # @return [String, nil]
          attr_accessor :email

          # Масив об'єктів з інформацією про недоступність.
          # @return [Array<SuppressionGetObject>, nil]
          attr_accessor :suppressions

          def initialize(
            status: nil,
            email: nil,
            suppressions: nil
          )
            @status = status
            @email = email
            @suppressions = suppressions
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              email: data['email'],
              suppressions: ::AllyMailer::Client::Decode.list(data['suppressions']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Suppression::Model::SuppressionGetObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'email' => @email,
              'suppressions' => @suppressions.nil? ? nil : @suppressions.map { |item0| item0.to_h },
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
