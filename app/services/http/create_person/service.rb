# frozen_string_literal: true

class Http::CreatePerson::Service < Http::Service
  option :serializer, default: -> { ::Serializer }
  option :transaction, default: -> { CreatePerson::Transaction }

  Contract = Http::CreatePerson::Contract

  def call
    transaction.new.(params) do
      _1.failure do |e|
        Rails.logger.error(e)
        [:internal_server_error]
      end

      _1.success do |created|
        [:created, created, serializer]
      end
    end
  end
end
