# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # EventDumpListResponse
        class EventDumpListResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Масив об'єктів, що описують дампи подій. Кожен об'єкт містить ті самі властивості, що й об'єкт
          # 'event_dump', який повертає метод
          # [event-dump/get](https://docs.allymailer.com.ua/ua/web-api-ref#event-dump-get).
          # @return [Array<EventDumpObject>, nil]
          attr_accessor :event_dumps

          def initialize(
            status: nil,
            event_dumps: nil
          )
            @status = status
            @event_dumps = event_dumps
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              event_dumps: ::AllyMailer::Client::Decode.list(data['event_dumps']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::EventDump::Model::EventDumpObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'event_dumps' => @event_dumps.nil? ? nil : @event_dumps.map { |item0| item0.to_h },
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
