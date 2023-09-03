# frozen_string_literal: true

class CreatePerson::Steps::Validate
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :contract, default: -> { CreatePerson::Contract.new }

  def call(params)
    contract.(params).to_monad
  end
end
