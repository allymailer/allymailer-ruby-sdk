# frozen_string_literal: true

module AllyMailer
  module Api
    module Obsolete
      module Model
        # Подробиці відписки:
        #
        # - "unsubscribed" якщо email було щойно відписано,
        # - "was inactive" якщо він уже був позначений як неактивний і немає сенсу відписувати,
        # - "was unsubscribed" якщо email уже було відписано раніше,
        # - "added and unsubscribed" якщо для цього email не зберігалося жодного більш раннього статусу, тому його було додано й одразу ж відписано.
        module ObsoleteUnsubscribedSetMessage
          UNSUBSCRIBED = 'unsubscribed'
          WAS_INACTIVE = 'was inactive'
          WAS_UNSUBSCRIBED = 'was unsubscribed'
          ADDED_AND_UNSUBSCRIBED = 'added and unsubscribed'

          # All values
          ALL = [UNSUBSCRIBED, WAS_INACTIVE, WAS_UNSUBSCRIBED, ADDED_AND_UNSUBSCRIBED].freeze
        end
      end
    end
  end
end
