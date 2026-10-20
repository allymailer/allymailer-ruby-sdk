# frozen_string_literal: true

module AllyMailer
  module Common
    module Model
      # Встановлює режим роботи лічильника листів. Дозволяє вибрати, як має поводитися лічильник:
      # автоматично скидатися чи залишатися постійним. Припустимі значення: default - лічильник автоматично
      # скидається в нуль на початку кожного облікового періоду, permanent - лічильник ніколи не скидається
      # автоматично. Скидання може бути виконане лише вручну користувачем, передавши значення 0 у полі
      # 'email_counter'. Якщо поле не передано в запиті або передано значення null, значення режиму не
      # змінюється.
      module EmailCounterMode
        DEFAULT = 'default'
        PERMANENT = 'permanent'

        # All values
        ALL = [DEFAULT, PERMANENT].freeze
      end
    end
  end
end
