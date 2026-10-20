# frozen_string_literal: true

module AllyMailer
  module Api
    module System
      module Model
        # SystemInfoResponse
        class SystemInfoResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Унікальний ідентифікатор користувача.
          # @return [Integer, nil]
          attr_accessor :user_id

          # Email користувача.
          # @return [String, nil]
          attr_accessor :email

          # Унікальний ідентифікатор проєкту, ASCII-рядок до 36 символів завдовжки. Присутній лише якщо
          # API-ключ, використаний для запиту, був API-ключем проєкту.
          # @return [String, nil]
          attr_accessor :project_id

          # Назва проєкту, унікальна в межах облікового запису користувача. Присутня лише якщо API-ключ,
          # використаний для запиту, був API-ключем проєкту.
          # @return [String, nil]
          attr_accessor :project_name

          # Об'єкт із властивостями лічильника листів. Присутній лише якщо API-ключ, використаний для запиту,
          # був API-ключем проєкту.
          # @return [ProjectAccountingObject, nil]
          attr_accessor :project_accounting

          # Об'єкт з властивостями періоду обліку. Присутній лише якщо API-ключ, використаний для запиту, був
          # API-ключем користувача.
          # @return [SystemInfoResponseAccounting, nil]
          attr_accessor :accounting

          def initialize(
            status: nil,
            user_id: nil,
            email: nil,
            project_id: nil,
            project_name: nil,
            project_accounting: nil,
            accounting: nil
          )
            @status = status
            @user_id = user_id
            @email = email
            @project_id = project_id
            @project_name = project_name
            @project_accounting = project_accounting
            @accounting = accounting
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              user_id: data['user_id'],
              email: data['email'],
              project_id: data['project_id'],
              project_name: data['project_name'],
              project_accounting: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::System::Model::ProjectAccountingObject, data['project_accounting']),
              accounting: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::System::Model::SystemInfoResponseAccounting, data['accounting'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'user_id' => @user_id,
              'email' => @email,
              'project_id' => @project_id,
              'project_name' => @project_name,
              'project_accounting' => @project_accounting.nil? ? nil : @project_accounting.to_h,
              'accounting' => @accounting.nil? ? nil : @accounting.to_h,
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
