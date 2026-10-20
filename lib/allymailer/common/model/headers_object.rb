# frozen_string_literal: true

module AllyMailer
  module Common
    module Model
      # Об'єкт, що містить додаткові заголовки листа, максимум 50 заголовків. Префікс “X-” в імені заголовка
      # обов'язковий, заголовки без нього будуть проігноровані, наприклад X-ALLYMAILER-Global-Language,
      # X-ALLYMAILER-Template-Engine. Стандартні заголовки "To", "CC", "BCC" передаються без префікса "X-",
      # але обробляються спеціальним чином, тому мають низку обмежень, докладніше про це можна прочитати
      # [тут](/cc-and-bcc). Також якщо [техпідтримка](https://cp.allymailer.com/ua/support) схвалила вам
      # вимкнення посилання відписки, то ви також можете передавати заголовки List-Unsubscribe,
      # List-Subscribe, List-Help, List-Owner, List-Archive, In-Reply-To і References.
      class HeadersObject
        # Wire names of the named fields
        FIELDS = ['X-ALLYMAILER-Global-Language', 'X-ALLYMAILER-Template-Engine'].freeze

        # Заголовок для вибору мови посилання та сторінки відписки. Припустимі значення "be", "de", "en",
        # "es", "fr", "it", "pl", "pt", "ru", "ua", "kz".
        # @return [String, nil]
        attr_accessor :x_allymailer_global_language

        # Заголовок для вибору шаблонізатора — або “simple”, або “velocity”, або “liquid”, або “none”. За
        # замовчуванням — “simple”. Має пріоритет над значенням, що передається в параметрі “template_engine”.
        # @return [String, nil]
        attr_accessor :x_allymailer_template_engine

        # Поля понад іменовані, передаються як є поруч із ними (іменоване поле важливіше), наприклад будь-який
        # заголовок X-*, 'CC', 'List-Unsubscribe': extra: { 'X-MyHeader' => 'some data' }. Сюди ж потрапляють
        # невідомі ключі відповіді.
        # @return [Hash{String => String}]
        attr_accessor :extra

        def initialize(
          x_allymailer_global_language: nil,
          x_allymailer_template_engine: nil,
          extra: {}
        )
          @x_allymailer_global_language = x_allymailer_global_language
          @x_allymailer_template_engine = x_allymailer_template_engine
          @extra = extra
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            x_allymailer_global_language: data['X-ALLYMAILER-Global-Language'],
            x_allymailer_template_engine: data['X-ALLYMAILER-Template-Engine'],
            extra: data.reject { |key, _| FIELDS.include?(key) }
          )
        end

        # JSON-ready hash, nil fields are omitted; the keys of extra go next to the named fields
        # (a named field wins).
        def to_h
          result = {
            'X-ALLYMAILER-Global-Language' => @x_allymailer_global_language,
            'X-ALLYMAILER-Template-Engine' => @x_allymailer_template_engine,
          }
          extra = (@extra || {}).transform_keys(&:to_s).reject { |key, value| result.key?(key) || value.nil? }
          extra.merge(result.compact)
        end

        def to_json(*args)
          to_h.to_json(*args)
        end
      end
    end
  end
end
