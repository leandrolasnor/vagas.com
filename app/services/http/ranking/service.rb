# frozen_string_literal: true

class Http::Ranking::Service < Http::Service
  option :serializer, type: Interface(:serializer_for), default: -> { Http::Ranking::Serializer }, reader: :private
  option :monad, type: Interface(:call), default: -> { Ranking::Monad.new }, reader: :private

  Contract = Http::Ranking::Contract.new

  def call
    res = monad.(params[:job_id])

    [:ok, res.value!, serializer]
  end
end
