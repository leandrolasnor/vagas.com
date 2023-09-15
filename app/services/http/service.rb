# frozen_string_literal: true

class Http::Service
  include Dry.Types()
  extend Dry::Initializer

  param :params, type: Hash, reader: :private

  def self.call(args)
    contract = self::Contract.call(args.to_h)
    return [:unprocessable_entity, contract.errors.to_h] if contract.failure?

    new(args.to_h).call
  rescue StandardError => error
    Rails.logger.error(error)
    [:internal_server_error]
  end
end
