# frozen_string_literal: true

module AllyMailer
  module Api
    module Template
      module Model
        # Тип редактора шаблону у вебінтерфейсі, "html" або "visual". За замовчуванням — "html". Створення
        # шаблонів із типом редактора "visual" можливе лише через вебінтерфейс.
        module EditorType
          HTML = 'html'
          VISUAL = 'visual'

          # All values
          ALL = [HTML, VISUAL].freeze
        end
      end
    end
  end
end
