# frozen_string_literal: true

module AllyMailer
  module Api
    module Project
      module Model
        # ProjectListResponse
        class ProjectListResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Масив об'єктів, де кожен об'єкт відповідає окремому проєкту.
          # @return [Array<ProjectListObject>, nil]
          attr_accessor :projects

          def initialize(
            status: nil,
            projects: nil
          )
            @status = status
            @projects = projects
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              projects: ::AllyMailer::Client::Decode.list(data['projects']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Project::Model::ProjectListObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'projects' => @projects.nil? ? nil : @projects.map { |item0| item0.to_h },
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
