# frozen_string_literal: true

class Http::CreateJob::Service < Http::Service
  option :serializer, default: -> { ::Serializer }
  option :transaction, default: -> { CreateJob::Transaction }

  Contract = ::Contract

  def call
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
