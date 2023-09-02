# frozen_string_literal: true

class CreateApplication::Steps::Validate
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :contract, default: -> { ::Contract }

  def call(params)
    validate = contract.new.(params)
    raise StandardError.new(validate.errors.to_h.to_json) if validate.failure?

    params
  end
end
