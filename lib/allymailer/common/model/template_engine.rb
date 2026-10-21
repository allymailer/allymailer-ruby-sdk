# frozen_string_literal: true

module AllyMailer
  module Common
    module Model
      # Параметр для вибору [шаблонізатора](https://docs.allymailer.com.ua/ua/template-engines) — або
      # "simple", або "velocity", або "liquid", або "none". За замовчуванням — "simple".
      module TemplateEngine
        SIMPLE = 'simple'
        VELOCITY = 'velocity'
        LIQUID = 'liquid'
        NONE = 'none'

        # All values
        ALL = [SIMPLE, VELOCITY, LIQUID, NONE].freeze
      end
    end
  end
end
