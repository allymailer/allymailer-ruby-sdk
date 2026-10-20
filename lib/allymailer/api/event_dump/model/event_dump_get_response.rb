# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # EventDumpGetResponse
        class EventDumpGetResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Об'єкт із властивостями дампа подій.
          # @return [EventDumpObject, nil]
          attr_accessor :event_dump

          def initialize(
            status: nil,
            event_dump: nil
          )
            @status = status
            @event_dump = event_dump
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              event_dump: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::EventDump::Model::EventDumpObject, data['event_dump'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'event_dump' => @event_dump.nil? ? nil : @event_dump.to_h,
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
