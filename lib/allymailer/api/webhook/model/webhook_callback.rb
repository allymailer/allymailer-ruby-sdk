# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Опис формату webhook.
        class WebhookCallback
          # MD5-хеш рядкового тіла повідомлення, у якому значення auth замінено на api_key користувача/проєкту,
          # чий обробник викликається. За допомогою цього отримувач сповіщення може як провести автентифікацію,
          # так і перевірити цілісність сповіщення.
          # @return [String, nil]
          attr_accessor :auth

          # Масив з одним елементом, що містить дані про події користувача/проєкту.
          # @return [Array<WebhookCallbackEventsByUserItem>, nil]
          attr_accessor :events_by_user

          def initialize(
            auth: nil,
            events_by_user: nil
          )
            @auth = auth
            @events_by_user = events_by_user
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              auth: data['auth'],
              events_by_user: ::AllyMailer::Client::Decode.list(data['events_by_user']) { |item0| ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Webhook::Model::WebhookCallbackEventsByUserItem, item0) }
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'auth' => @auth,
              'events_by_user' => @events_by_user.nil? ? nil : @events_by_user.map { |item0| item0.to_h },
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
