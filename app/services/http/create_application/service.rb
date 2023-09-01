# frozen_string_literal: true

class Http::CreateApplication::Service < Http::Service
  option :serializer, default: -> { ::Serializer }
  option :transaction, default: -> { CreateApplication::Transaction }
  option :worker, default: -> { ::CalculateScore::Worker }

  Contract = ::Contract

  def call
    transaction.
      operations[:create].
      subscribe('created') { worker.perform_async(_1[:application].id) }

    transaction.new.(params) do
      _1.failure do |e|
        [e.message, :internal_server_error]
      end

      _1.success do |created|
        [created, :created, serializer]
      end
    end
  end
end
