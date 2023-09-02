# frozen_string_literal: true

class Http::CreateApplication::Service < Http::Service
  option :serializer, default: -> { ::Serializer }
  option :transaction, default: -> { CreateApplication::Transaction }
  option :job, default: -> { ::CalculateScore::Job }

  Contract = Http::CreateApplication::Contract

  def call
    transaction.
      operations[:create].
      subscribe('created') { job.perform_later(_1[:application].id) }

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
