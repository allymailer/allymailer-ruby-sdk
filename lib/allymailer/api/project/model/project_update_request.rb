# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # ProjectUpdateRequest
        class ProjectUpdateRequest
          # Ідентифікатор проєкту, що оновлюється. Проєкт має бути ідентифіковано або цим полем project_id, або
          # полем project_api_key. Ми рекомендуємо використовувати project_id, це безпечніше.
          # @return [String, nil]
          attr_accessor :project_id

          # Необов'язковий API-ключ проєкту, що оновлюється. Проєкт має бути ідентифіковано або полем
          # project_id, або полем project_api_key. Ми рекомендуємо використовувати project_id, це безпечніше.
          # @return [String, nil]
          attr_accessor :project_api_key

          # Об'єкт із властивостями проєкту.
          # @return [ProjectUpdateObject, nil]
          attr_accessor :project

          def initialize(
            project:,
            project_id: nil,
            project_api_key: nil
          )
            @project_id = project_id
            @project_api_key = project_api_key
            @project = project
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              project: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Project::Model::ProjectUpdateObject, data['project']),
              project_id: data['project_id'],
              project_api_key: data['project_api_key']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'project_id' => @project_id,
              'project_api_key' => @project_api_key,
              'project' => @project.nil? ? nil : @project.to_h,
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
