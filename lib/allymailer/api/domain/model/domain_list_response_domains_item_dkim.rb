# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # Об'єкт, що описує DKIM-запис та її статус.
        class DomainListResponseDomainsItemDkim
          # DKIM-підпис для домену. У цьому полі повертається лише ключ. Щоб DNS-запис був коректним, перед
          # ключем потрібно додати "k=rsa, p=" (див.
          # [domain/get-dns-records](https://docs.allymailer.com.ua/ua/web-api-ref#domain-get-dns-records)).
          # @return [String, nil]
          attr_accessor :key

          # Лише домени зі статусом DKIM-запису "active" можуть використовуватися для надсилання листів.
          # @return [DkimStatus, nil]
          attr_accessor :status

          def initialize(
            key: nil,
            status: nil
          )
            @key = key
            @status = status
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              key: data['key'],
              status: data['status']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'key' => @key,
              'status' => @status,
            }.compact
          end

          def to_json(*args)
            to_h.to_json(*args)
          end
        end
      end
    end
  end
end
