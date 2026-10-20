# frozen_string_literal: true

module AllyMailer
  module Api
    module Tag
      module Model
        # TagListResponse
        class TagListResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Масив об'єктів з даними користувацьких міток.
          # @return [Array<TagsResponseObject>, nil]
          attr_accessor :tags

          def initialize(
            status: nil,
            tags: nil
          )
            @status = status
            @tags = tags
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              tags: ::AllyMailer::Client::Decode.list(data['tags']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Tag::Model::TagsResponseObject, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'tags' => @tags.nil? ? nil : @tags.map { |item0| item0.to_h },
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
