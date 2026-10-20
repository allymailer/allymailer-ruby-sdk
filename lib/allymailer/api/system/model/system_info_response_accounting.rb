# frozen_string_literal: true

module AllyMailer
  module Api
    module System
      module Model
        # Об'єкт з властивостями періоду обліку. Присутній лише якщо API-ключ, використаний для запиту, був
        # API-ключем користувача.
        class SystemInfoResponseAccounting
          # Дата й час початку періоду обліку в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :period_start

          # Дата й час кінця періоду обліку в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс".
          # @return [String, nil]
          attr_accessor :period_end

          # Кількість листів, включених в обліковий період.
          # @return [Integer, nil]
          attr_accessor :emails_included

          # Кількість листів, надісланих за обліковий період. Може бути більшою за emails_included у разі
          # перевищення.
          # @return [Integer, nil]
          attr_accessor :emails_sent

          def initialize(
            period_start: nil,
            period_end: nil,
            emails_included: nil,
            emails_sent: nil
          )
            @period_start = period_start
            @period_end = period_end
            @emails_included = emails_included
            @emails_sent = emails_sent
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              period_start: data['period_start'],
              period_end: data['period_end'],
              emails_included: data['emails_included'],
              emails_sent: data['emails_sent']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'period_start' => @period_start,
              'period_end' => @period_end,
              'emails_included' => @emails_included,
              'emails_sent' => @emails_sent,
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
