# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module EmailValidation
      # Методи перевірки email-адрес. Перевірка адреси електронної пошти надає докладну інформацію про
      # працездатність email. Це дозволить виключити з надсилання неіснуючі email, знизити показник скарг,
      # очистити список підписників і врешті-решт покращити вашу репутацію як відправника. Наприклад, ви
      # можете інтегрувати процес перевірки у форму реєстрації вашого сайту і вже на етапі введення адреси
      # повідомляти користувачам, що адреса, яку вони ввели у форму, недійсна.
      class EmailValidationApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Допускається не більше ніж два одночасні запити; у разі перевищення буде повернуто помилку. Оскільки
        # перевірка має бути швидкою, ми обмежуємо час, що витрачається на перевірку адреси електронної пошти.
        # Тому, якщо ми зіткнемося з повільним поштовим сервером, час відповіді якого перевищує 5 секунд,
        # результат перевірки може бути невідомим.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#email-validation-single
        # @param request [::AllyMailer::Api::EmailValidation::Model::EmailValidationSingleRequest, Hash]
        # @return [::AllyMailer::Api::EmailValidation::Model::EmailValidationSingleResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def single(request)
          ::AllyMailer::Api::EmailValidation::Model::EmailValidationSingleResponse.from_h(@client.call('/email-validation/single.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
