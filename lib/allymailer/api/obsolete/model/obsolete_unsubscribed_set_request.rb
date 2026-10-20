# frozen_string_literal: true

module AllyMailer
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedSetRequest
        class ObsoleteUnsubscribedSetRequest
          # Email, який має бути відписано.
          # @return [String, nil]
          attr_accessor :address

          def initialize(
            address:
          )
            @address = address
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              address: data['address']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'address' => @address,
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
