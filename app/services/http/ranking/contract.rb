# frozen_string_literal: true

class Http::Ranking::Contract < Dry::Validation::Contract
  params do
    required(:job_id).filled(:integer)
  end
end
