# frozen_string_literal: true

class CreateApplication::Steps::Validate
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :contract, default: -> { CreateApplication::Contract.new }

  def call(params)
    contract.(params).to_monad
  end
end
