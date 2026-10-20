# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # WebhookCallbackEventsByUserItemEventsItem
        class WebhookCallbackEventsByUserItemEventsItem
          # Тип даних, що містяться в об'єкті event_data. Або "transactional_email_status", або
          # "transactional_spam_block".
          # @return [EventName, nil]
          attr_accessor :event_name

          # Об'єкт з різними властивостями події, що залежать від поля "event_name". Нижче перелічено всі
          # можливі властивості, спочатку для події "transactional_email_status", потім для події
          # "transactional_spam_block".
          # @return [WebhookCallbackEventsByUserItemEventsItemEventData, nil]
          attr_accessor :event_data

          def initialize(
            event_name: nil,
            event_data: nil
          )
            @event_name = event_name
            @event_data = event_data
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              event_name: data['event_name'],
              event_data: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Webhook::Model::WebhookCallbackEventsByUserItemEventsItemEventData, data['event_data'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'event_name' => @event_name,
              'event_data' => @event_data.nil? ? nil : @event_data.to_h,
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
