# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # DomainGetDnsRecordsResponse
        class DomainGetDnsRecordsResponse
          # Рядок "success".
          # Допустимі значення: `success`.
          # @return [String, nil]
          attr_accessor :status

          # Домен, для якого потрібно отримати інформацію про DNS-записи.
          # @return [String, nil]
          attr_accessor :domain

          # Запис, який потрібно внести "як є" для підтвердження володіння цим доменом.
          # @return [String, nil]
          attr_accessor :verification_record

          # DKIM-підпис для домену. У цьому полі повертається лише ключ. Щоб TXT-запис був коректним, перед
          # ключем потрібно додати "v=DKIM1; k=rsa; p=".
          # @return [String, nil]
          attr_accessor :dkim

          # Значення CNAME-запису для хоста "_dmarc" домену.
          # @return [String, nil]
          attr_accessor :dmarc

          def initialize(
            status: nil,
            domain: nil,
            verification_record: nil,
            dkim: nil,
            dmarc: nil
          )
            @status = status
            @domain = domain
            @verification_record = verification_record
            @dkim = dkim
            @dmarc = dmarc
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              status: data['status'],
              domain: data['domain'],
              verification_record: data['verification-record'],
              dkim: data['dkim'],
              dmarc: data['dmarc']
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'status' => @status,
              'domain' => @domain,
              'verification-record' => @verification_record,
              'dkim' => @dkim,
              'dmarc' => @dmarc,
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
