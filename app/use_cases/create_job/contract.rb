# frozen_string_literal: true

class CreateJob::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:nivel).value(included_in?: CreateJob::Model::Job.levels.keys)
  end
end
