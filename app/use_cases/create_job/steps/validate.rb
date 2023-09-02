# frozen_string_literal: true

class CreateJob::Steps::Validate
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :contract, default: -> { CreateJob::Contract.new }

  def call(params)
    validate = contract.(params)
    Failure(validate.errors.to_h.to_json) if validate.failure?

    params
  end
end
