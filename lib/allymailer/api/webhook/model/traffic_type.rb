# frozen_string_literal: true

module AllyMailer
  module Api
    module Webhook
      module Model
        # Якість трафіку для статусів "opened" і "clicked". "human" — розпізнано звичайний браузер або
        # поштовий клієнт без машинних ознак; "machine" — бот, сканер посилань або проксі безпеки; "protected"
        # — механізм приватності скриньки/ОС, участь людини підтвердити не можна (Apple Mail Privacy
        # Protection / iCloud Private Relay, Gmail Image Proxy; Apple MPP — це protected, не machine);
        # "unknown" — User-Agent відсутній, пошкоджений або не розпізнаний.
        module TrafficType
          HUMAN = 'human'
          MACHINE = 'machine'
          PROTECTED = 'protected'
          UNKNOWN = 'unknown'

          # All values
          ALL = [HUMAN, MACHINE, PROTECTED, UNKNOWN].freeze
        end
      end
    end
  end
end
