# frozen_string_literal: true

module AllyMailer
  module Api
    module EmailValidation
      module Model
        # EmailValidationSingleResponse
        class EmailValidationSingleResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Email, що перевіряється.
          # @return [String, nil]
          attr_accessor :email

          # Можливі статуси:
          #
          # - "valid" - email-адреса дійсна,
          # - "invalid" - email-адреса недійсна,
          # - "suspicious" - email-адреса підозріла,
          # - "unknown" - адресу не вдалося перевірити. Приймаючий сервер не відповів у межах припустимого часу перевірки.
          # @return [String, nil]
          attr_accessor :result

          # Можливі статуси:
          #
          # - "no_mx_record" - у домену відсутні MX-записи,
          # - "syntax_error" - адреса не відповідає стандартам email,
          # - "possible_typo" - можливо, адресу введено з помилкою,
          # - "mailbox_not_found" - адреса не існує,
          # - "global_suppression" - адреса перманентно недоступна в сервісі через багаторазові недоставки,
          # - "disposable" - одноразовий email, зазвичай такі адреси приймають пошту лише декілька хвилин,
          # - "role" - загальна адреса електронної пошти, найчастіше використовується групою людей і не належить конкретній особі,
          # - "abuse" - адреси, з яких надходить велика кількість скарг і натискань на "спам", іноді навіть в автоматичному режимі,
          # - "spamtrap" - адреси-спам-пастки, зазвичай розміщуються поштовими провайдерами у відкритому доступі, але ніколи не використовуються для підписки. Надсилання листів на такі адреси сильно шкодить репутації відправника,
          # - "smtp_connection_failed" - SMTP-сервер недоступний — можливо, адресу введено з помилкою.
          # @return [String, nil]
          attr_accessor :cause

          # Імовірність того, що адреса дійсна. Від 0 до 100 (100 - дійсна, 0 - недійсна).
          # @return [Integer, nil]
          attr_accessor :validity

          # Локальна частина email-адреси (усе, що перед знаком "@").
          # @return [String, nil]
          attr_accessor :local_part

          # Доменна частина email-адреси.
          # @return [String, nil]
          attr_accessor :domain

          # Чи є у домену MX-запис? true якщо є, false якщо відсутній.
          # @return [Boolean, nil]
          attr_accessor :mx_found

          # Бажана MX-запис домену.
          # @return [String, nil]
          attr_accessor :mx_record

          # Можлива адреса, отримана після виправлення помилки (для cause=possible_typo).
          # @return [String, nil]
          attr_accessor :did_you_mean

          # Дата й час перевірки адреси у форматі РРРР-ММ-ДД гг:хх:сс у часовому поясі UTC.
          # @return [String, nil]
          attr_accessor :processed_at

          def initialize(
            status: nil,
            email: nil,
            result: nil,
            cause: nil,
            validity: nil,
            local_part: nil,
            domain: nil,
            mx_found: nil,
            mx_record: nil,
            did_you_mean: nil,
            processed_at: nil
          )
            @status = status
            @email = email
            @result = result
            @cause = cause
            @validity = validity
            @local_part = local_part
            @domain = domain
            @mx_found = mx_found
            @mx_record = mx_record
            @did_you_mean = did_you_mean
            @processed_at = processed_at
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              email: data['email'],
              result: data['result'],
              cause: data['cause'],
              validity: data['validity'],
              local_part: data['local_part'],
              domain: data['domain'],
              mx_found: data['mx_found'],
              mx_record: data['mx_record'],
              did_you_mean: data['did_you_mean'],
              processed_at: data['processed_at']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'email' => @email,
              'result' => @result,
              'cause' => @cause,
              'validity' => @validity,
              'local_part' => @local_part,
              'domain' => @domain,
              'mx_found' => @mx_found,
              'mx_record' => @mx_record,
              'did_you_mean' => @did_you_mean,
              'processed_at' => @processed_at,
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
