# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # Лише домени зі статусом DKIM-запису "active" можуть використовуватися для надсилання листів.
        module DkimStatus
          ACTIVE = 'active'
          INACTIVE = 'inactive'

          # All values
          ALL = [ACTIVE, INACTIVE].freeze
        end
      end
    end
  end
end
