# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Формат сповіщень. "json_post"(за замовчуванням) або "json_post_gzip".
        module WebhookEventFormat
          JSON_POST = 'json_post'
          JSON_POST_GZIP = 'json_post_gzip'

          # All values
          ALL = [JSON_POST, JSON_POST_GZIP].freeze
        end
      end
    end
  end
end
