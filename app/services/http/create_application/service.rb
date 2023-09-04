# frozen_string_literal: true

class Http::CreateApplication::Service < Http::Service
  option :serializer, default: -> { Http::CreateApplication::Serializer }
  option :transaction, default: -> { CreateApplication::Transaction.new }
  option :worker, default: -> { Http::CreateApplication::CalculateScore::Job }
  option :queueer, default: -> { Proc.new { Resque.enqueue(worker, _1) } }

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
