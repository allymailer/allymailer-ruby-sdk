# frozen_string_literal: true

module AllyMailer
  module Common
    module Model
      # Лише домени зі статусом "confirmed" запису про володіння доменом можуть використовуватися для
      # надсилання листів.
      module VerificationRecordStatus
        CONFIRMED = 'confirmed'
        UNCONFIRMED = 'unconfirmed'

        # All values
        ALL = [CONFIRMED, UNCONFIRMED].freeze
      end
    end
  end
end
