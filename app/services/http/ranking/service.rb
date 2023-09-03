# frozen_string_literal: true

class Http::Ranking::Service < Http::Service
  option :serializer, default: -> { Http::Ranking::Serializer }
  option :monad, default: -> { Ranking::Monad.new }

  Contract = Http::Ranking::Contract.new

  def call
    res = monad.(params[:job_id])

    [:ok, res.value!, serializer]
  end
end
