# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Статус webhook, за замовчуванням "active". Статус "disabled" означає, що webhook було вимкнено
        # користувачем, "stopped" означає, що webhook було зупинено системою після 24 годин невдалих викликів
        # (мінімум за 10 різними подіями).
        module WebhookStatus
          ACTIVE = 'active'
          DISABLED = 'disabled'
          STOPPED = 'stopped'

          # All values
          ALL = [ACTIVE, DISABLED, STOPPED].freeze
        end
      end
    end
  end
end
