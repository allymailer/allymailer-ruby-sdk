# frozen_string_literal: true

module AllyMailer
  module Api
    module Tag
      module Model
        # Об'єкт із властивостями користувацьких міток.
        class TagsResponseObject
          # Унікальний id мітки.
          # @return [Integer, nil]
          attr_accessor :tag_id

          # Назва мітки.
          # @return [String, nil]
          attr_accessor :tag

          def initialize(
            tag_id: nil,
            tag: nil
          )
            @tag_id = tag_id
            @tag = tag
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              tag_id: data['tag_id'],
              tag: data['tag']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'tag_id' => @tag_id,
              'tag' => @tag,
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
