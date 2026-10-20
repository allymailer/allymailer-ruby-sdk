# frozen_string_literal: true

require 'json'

module AllyMailer
  module Api
    module Domain
      # Методи для налаштування доменів надсилання та перевірки їх статусів. Корисні, якщо вам недостатньо
      # додавання доменів через вебінтерфейс AllyMailer і, наприклад, хочеться автоматизувати додавання
      # доменів для ваших власних клієнтів.
      #
      # Щоб додати новий домен надсилання через API, ви маєте зробити таке:
      # - Підтвердіть домен, з якого надсилатимуться листи, внісши необхідні DNS-записи, отримавши їх за допомогою методу [domain/get-dns-records](https://docs.allymailer.com.ua/ua/web-api-ref#domain-get-dns-records).
      # - Після додавання раз на 5–10 хвилин викликайте [domain/list](https://docs.allymailer.com.ua/ua/web-api-ref#domain-list) із зазначенням доданого домену (або кількох доменів одразу, якщо перевірити треба декілька) і перевіряйте verification-record.status та dkim.status у відповіді domain/list. Можна робити запит і частіше — але точно не частіше за раз на хвилину.
      # - Якщо verification-record.status="unconfirmed", то ініціюйте перевірку правильності запису володіння доменом за допомогою виклику [domain/validate-verification-record](https://docs.allymailer.com.ua/ua/web-api-ref#domain-validate-verification-record).
      # - Якщо dkim.status="inactive", то ініціюйте перевірку правильності DKIM-запису за допомогою виклику [domain/validate-dkim](https://docs.allymailer.com.ua/ua/web-api-ref#domain-validate-dkim) (втім, DKIM-записи AllyMailer і сам перевіряє раз на пів години).
      # - І лише коли domain/list повернув verification-record.status="confirmed" та dkim.status="active" для домену, можна використовувати домен для надсилання та припинити його очікування й виклики для нього зазначених вище методів.
      class DomainApi
        # @param client [::AllyMailer::Client::ApiClient]
        def initialize(client)
          @client = client
        end

        # Повертає інформацію про записи, які потрібно внести в DNS для використання домену в AllyMailer.
        #
        # Щоб надсилати листи, вам потрібно підтвердити володіння доменом, зі зворотною адресою якого ви
        # збираєтеся їх надсилати, а також налаштувати DKIM-підпис для цього домену. Метод дозволяє вам
        # зареєструвати домен у AllyMailer і згенерувати запис для перевірки володіння та DKIM-ключ, або
        # отримати їх, якщо вони були згенеровані раніше.
        #
        # Після отримання успішної відповіді вам потрібно додати DNS-записи на кшталт цих:
        #
        # `@             IN TXT "allymailer-validate-hash=483bb362ebdbeedd755cfb1d4d661"`
        #
        # `us._domainkey IN TXT "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDo7"`
        #
        # `@             IN TXT  "v=spf1 include:spf.allymailer.com.ua ~all"`
        #
        # - Перший запис представлено вмістом поля "verification-record".
        # - Другий запис має включати вміст поля "dkim" одразу після "p=". Зверніть увагу на ім'я запису! Префікс "us._domainkey." дуже важливий для того, щоб DKIM-селектор AllyMailer працював правильно.
        # - Третій запис необов'язковий, але ми дуже рекомендуємо його додавати — це SPF-запис, який підвищує доставлюваність. Можливо, вона у вас уже є — у цьому разі просто додайте include:spf.allymailer.com.ua після v=spf1.
        #
        # Вимоги до синтаксису записів у різних DNS-провайдерів можуть відрізнятися:
        # - іноді потрібно вказувати повне ім'я домену із завершальною крапкою, на кшталт "example.com." замість символа @.
        # - деякі провайдери вимагають указувати час життя (TTL, наприклад 3600)
        # - для деяких провайдерів буде зайвим поміщення значень у подвійні лапки
        # Будь ласка, перевірте вимоги свого провайдера й підкажіть це своїм користувачам.
        #
        # Для реалізації white-label рішень є можливість змінити стандартні DNS-записи на ті, що не містять
        # підрядка "allymailer". Щоб дізнатися докладніше — напишіть у техпідтримку.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-get-dns-records
        # @param request [::AllyMailer::Api::Domain::Model::DomainGetDnsRecordsRequest, Hash]
        # @return [::AllyMailer::Api::Domain::Model::DomainGetDnsRecordsResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def get_dns_records(request)
          ::AllyMailer::Api::Domain::Model::DomainGetDnsRecordsResponse.from_h(@client.call('/domain/get-dns-records.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Ініціює перевірку запису про володіння доменом.
        #
        # Якщо результат виклику цього методу успішний (200 OK) — це означає, що перевірку запущено. Для
        # отримання результату потрібно пізніше перевірити поле verification-record.status, що повертається
        # методом [domain/list](https://docs.allymailer.com.ua/ua/web-api-ref#domain-list). Докладніше читайте
        # [тут](https://docs.allymailer.com.ua/ua/web-api-ref#domain).
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-validate-verification-record
        # @param request [::AllyMailer::Api::Domain::Model::DomainValidateVerificationRecordRequest, Hash]
        # @return [::AllyMailer::Api::Domain::Model::DomainValidateVerificationRecordResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def validate_verification_record(request)
          ::AllyMailer::Api::Domain::Model::DomainValidateVerificationRecordResponse.from_h(@client.call('/domain/validate-verification-record.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Перевіряє DKIM-запис домену.
        #
        # Якщо результат виклику цього методу успішний (200 OK) — це означає, що перевірку запущено. Для
        # отримання результату потрібно пізніше перевірити поле dkim.status, що повертається методом
        # [domain/list](https://docs.allymailer.com.ua/ua/web-api-ref#domain-list). Докладніше читайте
        # [тут](https://docs.allymailer.com.ua/ua/web-api-ref#domain).
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-validate-dkim
        # @param request [::AllyMailer::Api::Domain::Model::DomainValidateDkimRequest, Hash]
        # @return [::AllyMailer::Api::Domain::Model::DomainValidateDkimResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def validate_dkim(request)
          ::AllyMailer::Api::Domain::Model::DomainValidateDkimResponse.from_h(@client.call('/domain/validate-dkim.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Повертає список усіх зареєстрованих доменів користувача або проєкту разом зі статусами останніх
        # перевірок.
        #
        # Повертає статус останньої перевірки DNS-запису володіння доменом і DKIM-запису для кожного домену.
        # Докладніше [тут](https://docs.allymailer.com.ua/ua/web-api-ref#domain).
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-list
        # @param request [::AllyMailer::Api::Domain::Model::DomainListRequest, Hash]
        # @return [::AllyMailer::Api::Domain::Model::DomainListResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def list(request)
          ::AllyMailer::Api::Domain::Model::DomainListResponse.from_h(@client.call('/domain/list.json', request.is_a?(Hash) ? request : request.to_h))
        end

        # Створює sandbox-домен облікового запису або повертає наявний.
        #
        # Повертає sandbox-домен облікового запису, готовий до використання в полі `from_email` методу
        # [email/send](https://docs.allymailer.com.ua/ua/web-api-ref#email-send). Якщо sandbox-домену немає,
        # AllyMailer створює його та повертає. Повторні виклики повертають той самий домен.
        #
        # Метод доступний лише з API-ключем облікового запису. API-ключі проєктів не можуть створювати
        # sandbox-домени.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-get-sandbox-domain
        # @return [::AllyMailer::Api::Domain::Model::DomainGetSandboxDomainResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def get_sandbox_domain
          ::AllyMailer::Api::Domain::Model::DomainGetSandboxDomainResponse.from_h(@client.call('/domain/get-sandbox-domain.json'))
        end

        # Видаляє домен. Увага: для видалення домену, що належить проєкту, вам потрібно використати API-ключ
        # проєкту.
        #
        # Видаляє домен.
        #
        # Документація: https://docs.allymailer.com.ua/ua/web-api-ref#domain-delete
        # @param request [::AllyMailer::Api::Domain::Model::DomainDeleteRequest, Hash]
        # @return [::AllyMailer::Api::Domain::Model::DomainDeleteResponse]
        # @raise [::AllyMailer::Client::ApiError]
        def delete(request)
          ::AllyMailer::Api::Domain::Model::DomainDeleteResponse.from_h(@client.call('/domain/delete.json', request.is_a?(Hash) ? request : request.to_h))
        end
      end
    end
  end
end
