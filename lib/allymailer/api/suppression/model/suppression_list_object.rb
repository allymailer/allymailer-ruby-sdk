# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # Об'єкт з даними про блокування email.
        class SuppressionListObject
          # Email-адреса, яка знаходиться в списку недоступних.
          # @return [String, nil]
          attr_accessor :email

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

          # Чи можна видалити запис за допомогою виклику suppression/delete.
          # @return [Boolean, nil]
          attr_accessor :is_deletable

          # Коли було встановлено недоступність, у часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :created

          def initialize(
            email: nil,
            cause: nil,
            source: nil,
            is_deletable: nil,
            created: nil
          )
            @email = email
            @cause = cause
            @source = source
            @is_deletable = is_deletable
            @created = created
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              cause: data['cause'],
              source: data['source'],
              is_deletable: data['is_deletable'],
              created: data['created']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'cause' => @cause,
              'source' => @source,
              'is_deletable' => @is_deletable,
              'created' => @created,
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
