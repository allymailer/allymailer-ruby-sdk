# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # SuppressionListRequest
        class SuppressionListRequest
          # Причина, з якої надсилання на цей email блокується. Одна з таких:
          #
          # - __unsubscribed__ - зазначену адресу відписано;
          # - __temporary_unavailable__ - адреса тимчасово недоступна. Це означає, що протягом наступних трьох діб надсилання на цю адресу повертатиме помилку. Email може бути тимчасово недоступним з різних причин, наприклад:
          #
          # - попереднє надсилання було відхилено сервером отримувача як спам;
          # - поштова скринька отримувача переповнена або не використовується;
          # - домен не приймає пошту через неправильне налаштування на боці отримувача або з інших причин;
          # - сервер відправника було відхилено через блеклистинг;
          #
          # - __permanent_unavailable__ - адреса перманентно недоступна через багаторазові недоставки;
          # - __complained__ - в одному з попередніх листів адресат натиснув “Це спам”.
          # - __blocked__ - надсилання на цю адресу заборонено адміністрацією AllyMailer.
          # У майбутньому можуть з'явитися й інші причини.
          # @return [String, nil]
          attr_accessor :cause

          # Джерело потрапляння до списку недоступних. Одне з таких:
          #
          # - __user__ - дії користувача за допомогою методу [suppression/set](https://docs.allymailer.com.ua/ua/web-api-ref#suppression-set);
          # - __system__ - надсилання на цю адресу заборонено системою, наприклад через багаторазові недоставки;
          # - __subscriber__ - у зв'язку з діями отримувача. В одному з попередніх листів адресат натиснув “Це спам” або відписався.
          # @return [String, nil]
          attr_accessor :source

          # Дата у форматі РРРР-ММ-ДД гг:хх:сс, щоб отримати список блокування з "start_time" по сьогоднішній
          # день. Ігнорується, якщо параметр “cursor” не порожній.
          # @return [String, nil]
          attr_accessor :start_time

          # Параметр указує, з якої позиції починати вибірку. Має бути порожнім або відсутнім для отримання
          # першої порції даних; для отримання другої та наступних порцій його необхідно задавати, підставляючи
          # значення поля "cursor" з попередньої порції.
          # @return [String, nil]
          attr_accessor :cursor

          # Максимум записів, що видаються за один раз, за замовчуванням 50.
          # @return [Integer, nil]
          attr_accessor :limit

          def initialize(
            cause: nil,
            source: nil,
            start_time: nil,
            cursor: nil,
            limit: nil
          )
            @cause = cause
            @source = source
            @start_time = start_time
            @cursor = cursor
            @limit = limit
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              cause: data['cause'],
              source: data['source'],
              start_time: data['start_time'],
              cursor: data['cursor'],
              limit: data['limit']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'cause' => @cause,
              'source' => @source,
              'start_time' => @start_time,
              'cursor' => @cursor,
              'limit' => @limit,
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
