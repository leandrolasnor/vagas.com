# frozen_string_literal: true

class Http::CreateJob::Service < Http::Service
  option :serializer, type: Interface(:serializer_for), default: -> { Http::CreateJob::Serializer }, reader: :private
  option :transaction, type: Interface(:call), default: -> { CreateJob::Transaction.new }, reader: :private

  Contract = Http::CreateJob::Contract.new

  def call
    transaction.(params) do
      _1.failure :validate do |f|
        [:unprocessable_entity, f.errors.to_h]
      end

      _1.failure do |f|
        Rails.logger.error(f)
        [:internal_server_error]
      end

      _1.success do |created|
        [:created, created, serializer]
      end
    end
  end
end
