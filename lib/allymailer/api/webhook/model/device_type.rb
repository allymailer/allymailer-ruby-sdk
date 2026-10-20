# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Тип пристрою отримувача, визначений за user agent. Присутній для статусів "clicked" і "opened";
        # дорівнює "unknown", якщо тип пристрою визначити не вдалося.
        module DeviceType
          DESKTOP = 'desktop'
          MOBILE = 'mobile'
          TABLET = 'tablet'
          OTHER = 'other'
          UNKNOWN = 'unknown'

          # All values
          ALL = [DESKTOP, MOBILE, TABLET, OTHER, UNKNOWN].freeze
        end
      end
    end
  end
end
