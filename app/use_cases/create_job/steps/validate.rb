# frozen_string_literal: true

class CreateJob::Steps::Validate
  include Dry::Monads[:result]
  include Dry::Events::Publisher
  extend  Dry::Initializer

  option :contract, default: -> { ::Contract }

  def call(params)
    validate = contract.new.(params)
    raise StandardError.new(validate.errors.to_h.to_json) if validate.failure?

    params
  end
end
