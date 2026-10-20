# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Тип спам-блока — заблоковано або один відправляючий SMTP, або одразу багато. У разі блокування
        # одиночного SMTP із загального пулу AllyMailer пробуватиме ще декілька. Властивість присутня лише
        # якщо event_name="transactional_spam_block".
        module BlockType
          ONE_SMTP = 'one_smtp'
          ALL_SMTP = 'all_smtp'

          # All values
          ALL = [ONE_SMTP, ALL_SMTP].freeze
        end
      end
    end
  end
end
