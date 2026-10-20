# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # DomainListRequest
        class DomainListRequest
          # Опціональне ім'я домену, якщо вам потрібно отримати статуси лише за одним доменом.
          # @return [String, nil]
          attr_accessor :domain

          # Максимальна кількість доменів, що повертаються. За замовчуванням 50.
          # За замовчуванням: `50`.
          # @return [Integer, nil]
          attr_accessor :limit

          # Індекс першого домену зі списку, що повертається, рахуючи з нуля.
          # За замовчуванням: `0`.
          # @return [Integer, nil]
          attr_accessor :offset

          def initialize(
            domain: nil,
            limit: nil,
            offset: nil
          )
            @domain = domain
            @limit = limit
            @offset = offset
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              domain: data['domain'],
              limit: data['limit'],
              offset: data['offset']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'domain' => @domain,
              'limit' => @limit,
              'offset' => @offset,
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
