# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # EventDumpCreateResponse
        class EventDumpCreateResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Ідентифікатор дампа. Використовується для виклику методу
          # [event-dump/get](https://docs.allymailer.com.ua/ua/web-api-ref#event-dump-get).
          # @return [String, nil]
          attr_accessor :dump_id

          def initialize(
            status: nil,
            dump_id: nil
          )
            @status = status
            @dump_id = dump_id
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              dump_id: data['dump_id']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'dump_id' => @dump_id,
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
