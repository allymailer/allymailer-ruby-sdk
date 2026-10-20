# frozen_string_literal: true

module AllyMailer
  module Api
    module Template
      module Model
        # TemplateGetResponse
        class TemplateGetResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Об'єкт, що містить властивості шаблону.
          # @return [TemplateObject, nil]
          attr_accessor :template

          def initialize(
            status: nil,
            template: nil
          )
            @status = status
            @template = template
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              template: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Template::Model::TemplateObject, data['template'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'template' => @template.nil? ? nil : @template.to_h,
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
