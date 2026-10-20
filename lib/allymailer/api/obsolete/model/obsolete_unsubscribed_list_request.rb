# frozen_string_literal: true

module AllyMailer
  module Api
    module Obsolete
      module Model
        # ObsoleteUnsubscribedListRequest
        class ObsoleteUnsubscribedListRequest
          # Дата у форматі РРРР-ММ-ДД, щоб отримати всі відписані адреси з "date_from" по сьогоднішній день.
          # Якщо параметр не вказати, період за замовчуванням буде з 00:00 сьогоднішнього дня за UTC.
          # @return [String, nil]
          attr_accessor :date_from

          def initialize(
            date_from: nil
          )
            @date_from = date_from
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              date_from: data['date_from']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'date_from' => @date_from,
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
