# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Email
      # Ця група методів пов'язана з надсиланням email.
      class EmailApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Метод для надсилання листів вашим підписникам.
        #
        # Під час надсилання ви можете використовувати підстановки змінних, шаблони, увімкнути відстеження
        # прочитань або переходів за посиланнями та багато іншого.
        #
        # Обмеження:
        # * максимальний розмір запиту — 10 MB
        # * максимальна кількість отримувачів (recipients) — 500 email
        # * у назві вкладень заборонено символ '/'
        #
        # Якщо під час надсилання листа у списку отримувачів будуть некоректно введені, неіснуючі, повторювані
        # або відписані адреси, вони будуть повернуті у відповіді за допомогою параметра failed_emails, лист
        # же буде надіслано на всі інші прийнятні адреси. Якщо всі адреси потраплять до failed_emails,
        # надсилання здійснено не буде, буде повернуто помилку з API-кодом 204.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#email-send
        # @param request [::AllyMailer::Api::Email::Model::EmailSendRequest, Hash]
        # @return [::AllyMailer::Api::Email::Model::EmailSendResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def send_email(request)
          ::AllyMailer::Api::Email::Model::EmailSendResponse.from_h(@client.call('/email/send.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Надіслати посилання на (пере)підписку.
        #
        # Метод дозволяє повторно підписати колишнього підписника, який відписався раніше, був заблокований
        # через скарги або чия адреса недоступна з якоїсь іншої причини.
        #
        # Під час виклику надсилається лист у нейтральному дизайні з посиланням підписки. При переході за
        # посиланням з email підписник перестає бути недоступним для користувача та/або перестає бути
        # глобально відписаним.
        #
        # За замовчуванням дозволено лише одне надсилання листа повторної підписки на добу. Якщо вам потрібно
        # більше — напишіть у техпідтримку.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#email-subscribe
        # @param request [::AllyMailer::Api::Email::Model::EmailSubscribeRequest, Hash]
        # @return [::AllyMailer::Common::Model::SuccessResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def subscribe(request)
          ::AllyMailer::Common::Model::SuccessResponse.from_h(@client.call('/email/subscribe.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
