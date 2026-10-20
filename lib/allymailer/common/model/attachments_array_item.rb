# frozen_string_literal: true

module AllyMailer
  module Common
    module Model
      # AttachmentsArrayItem
      class AttachmentsArrayItem
        # Тип вкладення, див. [MIME](https://en.wikipedia.org/wiki/MIME). Якщо не впевнені, використовуйте
        # "application/octet-stream".
        # @return [String, nil]
        attr_accessor :type

        # Назва вкладення у форматі: "ім'я.розширення". У разі передачі кількох вкладень їхні назви мають бути
        # унікальними. У назві вкладень заборонено символ ‘/’.
        # @return [String, nil]
        attr_accessor :name

        # Вміст файлу у [base64](https://en.wikipedia.org/wiki/Base64). Максимальний розмір файлу 7 Мб
        # (9786710 байт у base64).
        # @return [String, nil]
        attr_accessor :content

        def initialize(
          type:,
          name:,
          content:
        )
          @type = type
          @name = name
          @content = content
        end

        # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
        # gives nil (data that is not a Hash gives an empty object).
        def self.from_h(data)
          data = {} unless data.is_a?(Hash)
          new(
            type: data['type'],
            name: data['name'],
            content: data['content']
          )
        end

        # JSON-ready hash, nil fields are omitted.
        def to_h
          {
            'type' => @type,
            'name' => @name,
            'content' => @content,
          }.compact
        end

        def to_json(*args)
          to_h.to_json(*args)
        end
      end
    end
  end
end
