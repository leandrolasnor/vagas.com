# frozen_string_literal: true

class CreateJob::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n
  params do
    required(:empresa).filled(:string)
    required(:titulo).filled(:string)
    required(:descricao).filled(:string)
    required(:localizacao).filled(:string)
    required(:nivel).filled(:integer)
  end
end
