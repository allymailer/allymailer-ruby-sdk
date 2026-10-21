# frozen_string_literal: true

module AllyMailer
  module Api
    module Template
      module Model
        # TemplateListObject
        class TemplateListObject
          # Унікальний ідентифікатор шаблону.
          # @return [String, nil]
          attr_accessor :id

          # Назва шаблону.
          # @return [String, nil]
          attr_accessor :name

          # Тип редактора шаблону у вебінтерфейсі, "html" або "visual". За замовчуванням — "html". Створення
          # шаблонів із типом редактора "visual" можливе лише через вебінтерфейс.
          # @return [EditorType, nil]
          attr_accessor :editor_type

          # Параметр для вибору [шаблонізатора](https://docs.allymailer.com.ua/ua/template-engines) — або
          # "simple", або "velocity", або "liquid", або "none". За замовчуванням — "simple".
          # @return [TemplateEngine, nil]
          attr_accessor :template_engine

          # Об'єкт для передачі глобальних підстановок (наприклад, назва компанії). Якщо назви змінних
          # повторюються в об'єкті користувацьких підстановок "substitutions", значення змінних будуть взяті з
          # об'єкта "substitutions". Підстановки працюють у параметрах:
          #
          # - body.html
          # - body.plaintext
          # - body.amp
          # - subject
          # - from_name
          # - options.unsubscribe_url
          # Назви змінних можуть містити літери латинського алфавіту, цифри, символ "_". Першим символом може
          # бути лише літера, використання пробілів не допускається.
          # @return [Hash{String => String}, nil]
          attr_accessor :global_substitutions

          # Об'єкт для передачі метаданих, спільних для всіх отримувачів, у форматі: "key": "value". Максимальна
          # кількість ключів: 10; максимальна довжина ключа: 64 символи; максимальна довжина значення ключа:
          # 1024 символи. Метадані передаються під час виклику
          # [webhook](https://docs.allymailer.com.ua/ua/web-api-ref#webhook). Для групування листів в одну
          # розсилку може використовуватися системний ключ "campaign_id" зі значенням у вигляді невід'ємного
          # десяткового цілого до 128 біт або UUID вигляду "c7703772-453e-4c77-a9ae-9a1b94051b5a". Неправильні
          # значення будуть прирівняні до '0'
          # @return [Hash{String => String}, nil]
          attr_accessor :global_metadata

          # Об'єкт, що містить у собі html-, plaintext- і amp-частини листа. Або html-, або plaintext-частина
          # має бути присутня обов'язково.
          # @return [BodyObject, nil]
          attr_accessor :body

          # Тема листа.
          # @return [String, nil]
          attr_accessor :subject

          # Email-адреса відправника.
          # @return [String, nil]
          attr_accessor :from_email

          # Ім'я відправника.
          # @return [String, nil]
          attr_accessor :from_name

          # Необов'язкова email-адреса для відповідей (на випадок, якщо відрізняється від адреси відправника)
          # @return [String, nil]
          attr_accessor :reply_to

          # Необов'язкове ім'я для відповідей (якщо вказано email reply_to і ви хочете, щоб відображався не лише
          # цей email, але й ім'я)
          # @return [String, nil]
          attr_accessor :reply_to_name

          # 1 = відстеження переходів за посиланнями увімкнено (значення за замовчуванням), 0=вимкнено. Для
          # використання track_links = 0 вам потрібно [попросити
          # техпідтримку](https://cp.allymailer.com/ua/support) увімкнути таку можливість.
          # Допустимі значення: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :track_links

          # 1 = відстеження прочитань листа увімкнено (значення за замовчуванням), 0 = вимкнено. Для
          # використання track_read = 0 вам потрібно [попросити
          # техпідтримку](https://cp.allymailer.com/ua/support) увімкнути таку можливість.
          # Допустимі значення: `0`, `1`.
          # @return [Integer, nil]
          attr_accessor :track_read

          # Об'єкт, що містить додаткові заголовки листа, максимум 50 заголовків. Префікс “X-” в імені заголовка
          # обов'язковий, заголовки без нього будуть проігноровані, наприклад X-ALLYMAILER-Global-Language,
          # X-ALLYMAILER-Template-Engine. Стандартні заголовки "To", "CC", "BCC" передаються без префікса "X-",
          # але обробляються спеціальним чином, тому мають низку обмежень, докладніше про це можна прочитати
          # [тут](/cc-and-bcc). Також якщо [техпідтримка](https://cp.allymailer.com/ua/support) схвалила вам
          # вимкнення посилання відписки, то ви також можете передавати заголовки List-Unsubscribe,
          # List-Subscribe, List-Help, List-Owner, List-Archive, In-Reply-To і References.
          # @return [HeadersObject, nil]
          attr_accessor :headers

          # Необов'язковий масив вкладень.
          # @return [Array<AttachmentsArrayItem>, nil]
          attr_accessor :attachments

          # Масив для передачі inline-вкладень, наприклад, для включення зображень у лист замість завантаження
          # їх за посиланням.
          # @return [Array<InlineAttachmentsArrayItem>, nil]
          attr_accessor :inline_attachments

          # Час створення шаблону в часовому поясі UTC у форматі "РРРР-ММ-ДД гг:хх:сс"
          # @return [String, nil]
          attr_accessor :created

          # Унікальний ідентифікатор користувача.
          # @return [Integer, nil]
          attr_accessor :user_id

          # Унікальний ідентифікатор проєкту, ASCII-рядок до 36 символів завдовжки.
          # @return [String, nil]
          attr_accessor :project_id

          # Назва проєкту, унікальна в межах облікового запису користувача.
          # @return [String, nil]
          attr_accessor :project_name

          def initialize(
            id: nil,
            name: nil,
            editor_type: nil,
            template_engine: nil,
            global_substitutions: nil,
            global_metadata: nil,
            body: nil,
            subject: nil,
            from_email: nil,
            from_name: nil,
            reply_to: nil,
            reply_to_name: nil,
            track_links: nil,
            track_read: nil,
            headers: nil,
            attachments: nil,
            inline_attachments: nil,
            created: nil,
            user_id: nil,
            project_id: nil,
            project_name: nil
          )
            @id = id
            @name = name
            @editor_type = editor_type
            @template_engine = template_engine
            @global_substitutions = global_substitutions
            @global_metadata = global_metadata
            @body = body
            @subject = subject
            @from_email = from_email
            @from_name = from_name
            @reply_to = reply_to
            @reply_to_name = reply_to_name
            @track_links = track_links
            @track_read = track_read
            @headers = headers
            @attachments = attachments
            @inline_attachments = inline_attachments
            @created = created
            @user_id = user_id
            @project_id = project_id
            @project_name = project_name
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              id: data['id'],
              name: data['name'],
              editor_type: data['editor_type'],
              template_engine: data['template_engine'],
              global_substitutions: ::AllyMailer::Client::Decode.map(data['global_substitutions']),
              global_metadata: ::AllyMailer::Client::Decode.map(data['global_metadata']),
              body: ::AllyMailer::Client::Decode.model(::AllyMailer::Common::Model::BodyObject, data['body']),
              subject: data['subject'],
              from_email: data['from_email'],
              from_name: data['from_name'],
              reply_to: data['reply_to'],
              reply_to_name: data['reply_to_name'],
              track_links: data['track_links'],
              track_read: data['track_read'],
              headers: ::AllyMailer::Client::Decode.model(::AllyMailer::Common::Model::HeadersObject, data['headers']),
              attachments: ::AllyMailer::Client::Decode.list(data['attachments']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Common::Model::AttachmentsArrayItem, item0) },
              inline_attachments: ::AllyMailer::Client::Decode.list(data['inline_attachments']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Common::Model::InlineAttachmentsArrayItem, item0) },
              created: data['created'],
              user_id: data['user_id'],
              project_id: data['project_id'],
              project_name: data['project_name']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'id' => @id,
              'name' => @name,
              'editor_type' => @editor_type,
              'template_engine' => @template_engine,
              'global_substitutions' => @global_substitutions,
              'global_metadata' => @global_metadata,
              'body' => @body.nil? ? nil : @body.to_h,
              'subject' => @subject,
              'from_email' => @from_email,
              'from_name' => @from_name,
              'reply_to' => @reply_to,
              'reply_to_name' => @reply_to_name,
              'track_links' => @track_links,
              'track_read' => @track_read,
              'headers' => @headers.nil? ? nil : @headers.to_h,
              'attachments' => @attachments.nil? ? nil : @attachments.map { |item0| item0.to_h },
              'inline_attachments' => @inline_attachments.nil? ? nil : @inline_attachments.map { |item0| item0.to_h },
              'created' => @created,
              'user_id' => @user_id,
              'project_id' => @project_id,
              'project_name' => @project_name,
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
