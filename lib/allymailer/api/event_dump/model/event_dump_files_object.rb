# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # Об'єкт із властивостями файлу дампа подій.
        class EventDumpFilesObject
          # Унікальний URL для завантаження файлу з розширенням .csv або .csv.gz, залежно від запитаного
          # формату.
          # @return [String, nil]
          attr_accessor :url

          # Розмір файлу.
          # @return [Integer, nil]
          attr_accessor :size

          def initialize(
            url: nil,
            size: nil
          )
            @url = url
            @size = size
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              url: data['url'],
              size: data['size']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'url' => @url,
              'size' => @size,
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
