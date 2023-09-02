# frozen_string_literal: true

class CreatePerson::Steps::Validate
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :contract, default: -> { ::Contract }

  def call(params)
    validate = contract.new.(params)
    Failure(validate.errors.to_h.to_json) if validate.failure?

    Success params
  end
end
