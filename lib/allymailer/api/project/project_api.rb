# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Project
      # Проєкти дозволяють об'єднати кілька незалежних доменів із webhook, шаблонами та списками відписки.
      # Це дуже корисно, якщо у вас є власні клієнти і ви керуєте їхніми даними з одного облікового запису
      # AllyMailer. Кожен проєкт отримує власний ключ API, а виклики методів API з цим ключем обробляють
      # лише дані цього проєкту. Таким чином, ви можете призначити окремий проєкт для кожного користувача і
      # бути впевненими, що вони не конфліктуватимуть: наприклад, відписка від одного проєкту не вплине на
      # інший.
      #
      # Методи проєктів за замовчуванням вимкнено через заходи захисту від спаму. Щоб їх увімкнути, вам
      # необхідно звернутися до [служби підтримки](https://cp.allymailer.com/ua/support).
      #
      # Зверніть увагу: за замовчуванням домени для надсилання підтверджуються та використовуються незалежно
      # для основного облікового запису й кожного з проєктів. Але є можливість увімкнути для проєктів
      # використання доменів, підтверджених в основному обліковому записі. Просто попросіть про це
      # [техпідтримку](https://cp.allymailer.com/ua/support).
      class ProjectApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Створити новий проєкт.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#project-create
        # @param request [::AllyMailer::Api::Project::Model::ProjectCreateRequest, Hash]
        # @return [::AllyMailer::Api::Project::Model::ProjectCreateResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def create(request)
          ::AllyMailer::Api::Project::Model::ProjectCreateResponse.from_h(@client.call('/project/create.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Змінити властивості проєкту.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#project-update
        # @param request [::AllyMailer::Api::Project::Model::ProjectUpdateRequest, Hash]
        # @return [::AllyMailer::Api::Project::Model::ProjectUpdateResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def update(request)
          ::AllyMailer::Api::Project::Model::ProjectUpdateResponse.from_h(@client.call('/project/update.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає список проєктів.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#project-list
        # @param request [::AllyMailer::Api::Project::Model::ProjectListRequest, Hash]
        # @return [::AllyMailer::Api::Project::Model::ProjectListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list(request)
          ::AllyMailer::Api::Project::Model::ProjectListResponse.from_h(@client.call('/project/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Видалити проєкт.
        #
        # Деякий час проєкт не видаляється остаточно, і його ще можна відновити — для цього необхідно
        # звернутися в техпідтримку.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#project-delete
        # @param request [::AllyMailer::Api::Project::Model::ProjectDeleteRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/project/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
