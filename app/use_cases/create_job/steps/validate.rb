# frozen_string_literal: true

class CreateJob::Steps::Validate
  include Dry::Monads[:result]
  extend Dry::Initializer

  option :contract, default: -> { CreateJob::Contract.new }

  def call(params)
    contract.(params).to_monad
  end
end
