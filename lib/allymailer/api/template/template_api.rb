# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Template
      # Ви можете зберегти шаблон на боці AllyMailer і потім посилатися на нього за ідентифікатором. Це не
      # обов'язково, але вкрай рекомендовано у разі повторюваних email-повідомлень або за великих обсягів
      # надсилання. AllyMailer підтримує два різні синтаксиси для шаблонів, докладніше читайте
      # [тут](https://docs.allymailer.com.ua/ua/template-engines).
      class TemplateApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Створити або оновити шаблон.
        #
        # Обмеження:
        # * Максимальний розмір запиту — 10 MB.
        # * Кількість шаблонів обмежено 10000.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#template-set
        # @param request [::AllyMailer::Api::Template::Model::TemplateSetRequest, Hash]
        # @return [::AllyMailer::Api::Template::Model::TemplateSetResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def set(request)
          ::AllyMailer::Api::Template::Model::TemplateSetResponse.from_h(@client.call('/template/set.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає властивості шаблону за його ідентифікатором.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#template-get
        # @param request [::AllyMailer::Api::Template::Model::TemplateGetRequest, Hash]
        # @return [::AllyMailer::Api::Template::Model::TemplateGetResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def get(request)
          ::AllyMailer::Api::Template::Model::TemplateGetResponse.from_h(@client.call('/template/get.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає повний список або частину списку всіх шаблонів.
        #
        # Ви можете переглядати великий список частинами, використовуючи параметри "offset" і "limit". Якщо
        # повернуто менше ніж "limit" шаблонів — значить, ви досягли кінця списку.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#template-list
        # @param request [::AllyMailer::Api::Template::Model::TemplateListRequest, Hash]
        # @return [::AllyMailer::Api::Template::Model::TemplateListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list(request)
          ::AllyMailer::Api::Template::Model::TemplateListResponse.from_h(@client.call('/template/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Видаляє шаблон за ідентифікатором.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#template-delete
        # @param request [::AllyMailer::Api::Template::Model::TemplateDeleteRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/template/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
