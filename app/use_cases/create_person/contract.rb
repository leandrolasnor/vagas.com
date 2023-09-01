# frozen_string_literal: true

class CreatePerson::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n
  params do
    required(:nome).filled(:string)
    required(:profissao).filled(:string)
    required(:localizacao).filled(:string)
    required(:nivel).filled(:integer)
  end
end
