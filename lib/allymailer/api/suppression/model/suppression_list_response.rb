# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # SuppressionListResponse
        class SuppressionListResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Масив об'єктів з інформацією про недоступність.
          # @return [Array<SuppressionListObject>, nil]
          attr_accessor :suppressions

          # Параметр указує, з якої позиції починати вибірку. Має бути порожнім або відсутнім для отримання
          # першої порції даних; для отримання другої та наступних порцій його необхідно задавати, підставляючи
          # значення поля "cursor" з попередньої порції.
          # @return [String, nil]
          attr_accessor :cursor

          def initialize(
            status: nil,
            suppressions: nil,
            cursor: nil
          )
            @status = status
            @suppressions = suppressions
            @cursor = cursor
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              suppressions: ::AllyMailer::Client::Decode.list(data['suppressions']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Suppression::Model::SuppressionListObject, item0) },
              cursor: data['cursor']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'suppressions' => @suppressions.nil? ? nil : @suppressions.map { |item0| item0.to_h },
              'cursor' => @cursor,
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
