# frozen_string_literal: true

module AllyMailer
  module Api
    module Domain
      module Model
        # DomainListResponseDomainsItem
        class DomainListResponseDomainsItem
          # Ім'я домену.
          # @return [String, nil]
          attr_accessor :domain

          # Об'єкт, що описує запис перевірки володіння та її статус.
          # @return [DomainListResponseDomainsItemVerificationRecord, nil]
          attr_accessor :verification_record

          # Об'єкт, що описує DKIM-запис та її статус.
          # @return [DomainListResponseDomainsItemDkim, nil]
          attr_accessor :dkim

          def initialize(
            domain: nil,
            verification_record: nil,
            dkim: nil
          )
            @domain = domain
            @verification_record = verification_record
            @dkim = dkim
          end

          # Builds the object from decoded JSON. Lenient: a missing field, nil or a value of another type
          # gives nil (data that is not a Hash gives an empty object).
          def self.from_h(data)
            data = {} unless data.is_a?(Hash)
            new(
              domain: data['domain'],
              verification_record: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Domain::Model::DomainListResponseDomainsItemVerificationRecord, data['verification-record']),
              dkim: ::AllyMailer::Client::Decode.model(::AllyMailer::Api::Domain::Model::DomainListResponseDomainsItemDkim, data['dkim'])
            )
          end

          # JSON-ready hash, nil fields are omitted.
          def to_h
            {
              'domain' => @domain,
              'verification-record' => @verification_record.nil? ? nil : @verification_record.to_h,
              'dkim' => @dkim.nil? ? nil : @dkim.to_h,
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
