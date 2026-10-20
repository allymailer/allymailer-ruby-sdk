# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # ProjectCreateResponse
        class ProjectCreateResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Унікальний ідентифікатор проєкту, ASCII-рядок до 36 символів завдовжки.
          # @return [String, nil]
          attr_accessor :project_id

          # API-ключ проєкту. Ви можете використовувати цей ключ замість користувацького api_key у всіх методах,
          # крім project-методів.
          # @return [String, nil]
          attr_accessor :project_api_key

          def initialize(
            status: nil,
            project_id: nil,
            project_api_key: nil
          )
            @status = status
            @project_id = project_id
            @project_api_key = project_api_key
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              project_id: data['project_id'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'project_id' => @project_id,
              'project_api_key' => @project_api_key,
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
