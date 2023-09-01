# frozen_string_literal: true

class Http::Service
  extend Dry::Initializer

  primary_abstract_class

  param :params

  def self.call(args)
    contract = self::Contract.call(args.to_h)
    return [contract.errors.to_h, :unprocessable_entity] if contract.failure?

    new(params: args).call
  rescue StandardError => error
    [error.message, :unprocessable_entity]
  end
end
