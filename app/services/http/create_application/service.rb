# frozen_string_literal: true

class Http::CreateApplication::Service < Http::Service
  option :serializer, type: Interface(:serializer_for), default: -> { Http::CreateApplication::Serializer }, reader: :private
  option :transaction, type: Interface(:call), default: -> { CreateApplication::Transaction.new }, reader: :private
  option :worker, type: Interface(:perform), default: -> { Http::CreateApplication::CalculateScore::Job }, reader: :private
  option :queueer, type: Instance(Proc), default: -> { proc { Resque.enqueue(worker, _1) } }, reader: :private

  Contract = Http::CreateApplication::Contract.new

  def call
    transaction.operations[:create].subscribe('application.created') do
      queueer.(_1[:application].id)
    end

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
