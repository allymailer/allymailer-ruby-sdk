# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Тип даних, що містяться в об'єкті event_data. Або "transactional_email_status", або
        # "transactional_spam_block".
        module EventName
          TRANSACTIONAL_EMAIL_STATUS = 'transactional_email_status'
          TRANSACTIONAL_SPAM_BLOCK = 'transactional_spam_block'

          # All values
          ALL = [TRANSACTIONAL_EMAIL_STATUS, TRANSACTIONAL_SPAM_BLOCK].freeze
        end
      end
    end
  end
end
