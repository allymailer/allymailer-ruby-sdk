# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # Об'єкт, що описує запис перевірки володіння та її статус.
        class DomainListResponseDomainsItemVerificationRecord
          # Запис, який потрібно внести "як є" для підтвердження володіння цим доменом.
          # @return [String, nil]
          attr_accessor :value

          # Лише домени зі статусом "confirmed" запису про володіння доменом можуть використовуватися для
          # надсилання листів.
          # @return [VerificationRecordStatus, nil]
          attr_accessor :status

          def initialize(
            value: nil,
            status: nil
          )
            @value = value
            @status = status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              value: data['value'],
              status: data['status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'value' => @value,
              'status' => @status,
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
