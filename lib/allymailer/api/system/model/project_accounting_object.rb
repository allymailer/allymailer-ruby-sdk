# frozen_string_literal: true

module AllyMailer
  module Api
    module System
      module Model
        # Об'єкт із властивостями лічильника листів. Присутній лише якщо API-ключ, використаний для запиту,
        # був API-ключем проєкту.
        class ProjectAccountingObject
          # Значення лічильника листів для проєкту, збільшується під час надсилання кожного листа.
          # @return [Integer, nil]
          attr_accessor :email_counter

          # Дозволяє обмежити кількість надісланих проєктом листів. У разі досягнення цього ліміту надсилання
          # припиняється. Значення 0 (за замовчуванням) означає відсутність ліміту.
          # @return [Integer, nil]
          attr_accessor :email_counter_limit

          # 'default' - лічильник автоматично скидається в нуль на початку кожного облікового періоду,
          # 'permanent' - лічильник ніколи не скидається автоматично.
          # За замовчуванням: `default`.
          # @return [EmailCounterMode, nil]
          attr_accessor :email_counter_mode

          def initialize(
            email_counter: nil,
            email_counter_limit: nil,
            email_counter_mode: nil
          )
            @email_counter = email_counter
            @email_counter_limit = email_counter_limit
            @email_counter_mode = email_counter_mode
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email_counter: data['email_counter'],
              email_counter_limit: data['email_counter_limit'],
              email_counter_mode: data['email_counter_mode']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email_counter' => @email_counter,
              'email_counter_limit' => @email_counter_limit,
              'email_counter_mode' => @email_counter_mode,
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
