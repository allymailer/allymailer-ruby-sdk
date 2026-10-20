# frozen_string_literal: true

module AllyMailer
  module Api
    module Suppression
      module Model
        # SuppressionGetRequest
        class SuppressionGetRequest
          # Email-адреса, для якої потрібно отримати дані про недоступність.
          # @return [String, nil]
          attr_accessor :email

          # Якщо у користувача увімкнено проєкти, all_projects=true дозволить шукати за даними всіх проєктів.
          # За замовчуванням: `False`.
          # @return [Boolean, nil]
          attr_accessor :all_projects

          def initialize(
            email:,
            all_projects: nil
          )
            @email = email
            @all_projects = all_projects
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              email: data['email'],
              all_projects: data['all_projects']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'email' => @email,
              'all_projects' => @all_projects,
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
