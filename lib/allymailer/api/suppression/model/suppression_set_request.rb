# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # SuppressionSetRequest
        class SuppressionSetRequest
          # Email-адреса, яку потрібно додати до списку недоступних.
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
          # @return [String, nil]
          attr_accessor :cause

          # Коли було встановлено недоступність, у часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :created

          def initialize(
            email:,
            cause:,
            created: nil
          )
            @email = email
            @cause = cause
            @created = created
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              cause: data['cause'],
              created: data['created']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'cause' => @cause,
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
