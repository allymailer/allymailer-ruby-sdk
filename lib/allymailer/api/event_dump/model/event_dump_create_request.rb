# frozen_string_literal: true

module AllyMailer
  module Api
    module EventDump
      module Model
        # EventDumpCreateRequest
        class EventDumpCreateRequest
          # Дата й час у форматі РРРР-ММ-ДД гг:хх:сс, починаючи з якої необхідно отримати події. Дані
          # зберігаються до 45 днів, залежно від вашого тарифу.
          # @return [String, nil]
          attr_accessor :start_time

          # Дата й час у форматі РРРР-ММ-ДД гг:хх:сс, до якої (не включно) запитуються події.
          # @return [String, nil]
          attr_accessor :end_time

          # Максимальна кількість подій, що повертаються, за замовчуванням 50. Якщо це значення перевищує 100
          # 000, буде створено декілька файлів, кожен з яких містить максимум 100 000 подій.
          # @return [Integer, nil]
          attr_accessor :limit

          # Якщо у користувача увімкнено проєкти, all_projects=true дозволить отримати дані всіх проєктів.
          # За замовчуванням: `False`.
          # @return [Boolean, nil]
          attr_accessor :all_projects

          # Об'єкт із властивостями фільтра дампа подій.
          # @return [FilterObject, nil]
          attr_accessor :filter

          # Масив із рядків з переліком назв стовпців, які необхідно отримати у вивантаженні (у порядку
          # переліку). Якщо 'dump_fields' відсутній або порожній — застосовується набір і порядок полів за
          # замовчуванням. Припустимі значення (у порядку за замовчуванням): 'project_id', 'event_time',
          # 'job_id', 'from_email', 'email', 'status', 'delivery_status', 'metadata', 'destination_response',
          # 'user_agent', 'url', 'ip', 'tags'. З метою більшої конфіденційності поле 'subject' не входить до
          # набору полів за замовчуванням, але ви можете додати його, вказавши в параметрі 'dump_fields'.
          # @return [Array<String>, nil]
          attr_accessor :dump_fields

          # Дозволяє отримати агреговану статистику за вказаний період. Може набувати одного з двох значень:
          #
          # - __day_status__ - отримати агреговану статистику; за такого значення параметр filter має бути відсутнім або порожнім об'єктом (фільтри неприпустимі);
          # - __порожній рядок__ - значення за замовчуванням, еквівалентне відсутності параметра aggregate, і метод event_dump/create у цьому разі працює як раніше.
          # @return [String, nil]
          attr_accessor :aggregate

          # Роздільник полів, за замовчуванням ','. Припустимі значення ',' і ';'.
          # @return [String, nil]
          attr_accessor :delimiter

          # Формат отримуваного файлу “csv” (за замовчуванням) або “csv_gzip”.
          # За замовчуванням: `csv`.
          # @return [String, nil]
          attr_accessor :format

          def initialize(
            start_time:,
            end_time: nil,
            limit: nil,
            all_projects: nil,
            filter: nil,
            dump_fields: nil,
            aggregate: nil,
            delimiter: nil,
            format: nil
          )
            @start_time = start_time
            @end_time = end_time
            @limit = limit
            @all_projects = all_projects
            @filter = filter
            @dump_fields = dump_fields
            @aggregate = aggregate
            @delimiter = delimiter
            @format = format
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              start_time: data['start_time'],
              end_time: data['end_time'],
              limit: data['limit'],
              all_projects: data['all_projects'],
              filter: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::EventDump::Model::FilterObject, data['filter']),
              dump_fields: ::AllyMailer::Client::Decode.list(data['dump_fields']),
              aggregate: data['aggregate'],
              delimiter: data['delimiter'],
              format: data['format']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'start_time' => @start_time,
              'end_time' => @end_time,
              'limit' => @limit,
              'all_projects' => @all_projects,
              'filter' => @filter.nil? ? nil : @filter.to_h,
              'dump_fields' => @dump_fields,
              'aggregate' => @aggregate,
              'delimiter' => @delimiter,
              'format' => @format,
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
