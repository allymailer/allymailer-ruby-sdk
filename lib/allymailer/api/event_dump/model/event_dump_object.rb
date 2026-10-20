# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # Об'єкт із властивостями дампа подій.
        class EventDumpObject
          # Ідентифікатор дампа, отриманий методом
          # [event-dump/create](https://docs.allymailer.com.ua/ua/web-api-ref#event-dump-create).
          # @return [String, nil]
          attr_accessor :dump_id

          # Статус задачі. Одне з чотирьох значень:
          #
          # - __queued__ - очікує в черзі, обробка ще не починалася;
          # - __in_process__ - триває обробка;
          # - __ready__ - обробку завершено, файли доступні для завантаження;
          # - __failed__ - обробку перервано з помилкою.
          # @return [String, nil]
          attr_accessor :dump_status

          # Масив об'єктів, кожен з яких позначає готовий до завантаження файл. Навіть якщо
          # "dump_status"="in_process", уже можна завантажувати ті файли, які вказані в "files". У разі
          # відсутності подій за заданими параметрами буде повернуто порожній масив.
          # @return [Array<EventDumpFilesObject>, nil]
          attr_accessor :files

          def initialize(
            dump_id: nil,
            dump_status: nil,
            files: nil
          )
            @dump_id = dump_id
            @dump_status = dump_status
            @files = files
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              dump_id: data['dump_id'],
              dump_status: data['dump_status'],
              files: ::AllyMailer::Client::Decode.list(data['files']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::EventDump::Model::EventDumpFilesObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'dump_id' => @dump_id,
              'dump_status' => @dump_status,
              'files' => @files.nil? ? nil : @files.map { |item0| item0.to_h },
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
