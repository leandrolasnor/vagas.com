# frozen_string_literal: true

class Http::CreateJob::Contract < Dry::Validation::Contract
  params do
    required(:empresa).filled(:string)
    required(:titulo).filled(:string)
    required(:descricao).filled(:string)
    required(:localizacao).filled(:string)
    required(:nivel).filled(:integer)
  end
end
