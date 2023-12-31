# frozen_string_literal: true

class CreateJob::Steps::Validate
  include Dry::Monads[:result]
  include Dry.Types()
  extend Dry::Initializer

  option :contract, type: Interface(:call), default: -> { CreateJob::Contract.new }, reader: :private

  def call(params)
    contract.(params).to_monad
  end
end
