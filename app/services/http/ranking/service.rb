# frozen_string_literal: true

class Http::Ranking::Service < Http::Service
  option :serializer, default: -> { ::Serializer }
  option :monad, default: -> { Ranking::Monad }

  Contract = Http::Ranking::Contract

  def call
    monad.new(params[:job_id]).call do
      _1.failure do |e|
        Rails.logger.error(e)
        [:internal_server_error]
      end

      _1.success do |list|
        [:ok, list, serializer]
      end
    end
  end
end
