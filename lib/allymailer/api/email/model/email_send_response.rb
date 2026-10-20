# frozen_string_literal: true

module AllyMailer
  module Api
    module Email
      module Model
        # EmailSendResponse
        class EmailSendResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Ідентифікатор завдання з надсилання, може виявитися корисним під час з'ясування причин збоїв.
          # @return [String, nil]
          attr_accessor :job_id

          # Масив email-адрес, успішно прийнятих до надсилання.
          # @return [Array<String>, nil]
          attr_accessor :emails

          # Об'єкт із email-адресами, не прийнятими до надсилання. Email представлено іменем властивості, а його
          # статус — значенням властивості, наприклад: {"email1@gmail.com": "temporary_unavailable"}. Можливі
          # статуси адрес, на які не вдалося здійснити надсилання:
          #
          # - __unsubscribed__ — зазначену адресу відписано;
          # - __invalid__ — адреса не існує або введена некоректно;
          # - __duplicate__ — адреса повторюється в запиті, повторне надсилання на той самий email запобігнуто;
          # - __temporary_unavailable__ — адреса тимчасово недоступна. Це означає, що протягом наступних трьох діб надсилання на цю адресу повертатиме помилку. Email може бути тимчасово недоступним з різних причин, наприклад:
          #
          # - попереднє надсилання було відхилено сервером отримувача як спам;
          # - поштова скринька отримувача переповнена або не використовується;
          # - домен не приймає пошту через неправильне налаштування на боці отримувача або з інших причин;
          # - сервер відправника було відхилено через блеклистинг;
          #
          # - __permanent_unavailable__ — адреса перманентно недоступна через багаторазові недоставки;
          # - __complained__ — в одному з попередніх листів адресат натиснув “Це спам”;
          # - __blocked__ — надсилання на цю адресу заборонено адміністрацією AllyMailer.
          # У майбутньому можуть з'явитися й інші статуси.
          # @return [Hash{String => String}, nil]
          attr_accessor :failed_emails

          def initialize(
            status: nil,
            job_id: nil,
            emails: nil,
            failed_emails: nil
          )
            @status = status
            @job_id = job_id
            @emails = emails
            @failed_emails = failed_emails
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              job_id: data['job_id'],
              emails: ::AllyMailer::Client::Decode.list(data['emails']),
              failed_emails: ::AllyMailer::Client::Decode.map(data['failed_emails'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'job_id' => @job_id,
              'emails' => @emails,
              'failed_emails' => @failed_emails,
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
