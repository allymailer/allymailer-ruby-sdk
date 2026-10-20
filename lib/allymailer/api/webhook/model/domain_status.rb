# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Це подія блокування чи розблокування. Властивість присутня лише якщо
        # event_name="transactional_spam_block".
        module DomainStatus
          BLOCKED = 'blocked'
          UNBLOCKED = 'unblocked'

          # All values
          ALL = [BLOCKED, UNBLOCKED].freeze
        end
      end
    end
  end
end
