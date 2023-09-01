# frozen_string_literal: true

class CreateApplication::Macros < Dry::Validation::Contract
  config.messages.backend = :i18n

  register_macro(:exists_person) do
    key(:id_person).failure(:person_not_found) unless Person.exists(values[:id_pessoa])
  end

  register_macro(:exists_job) do
    key(:id_vaga).failure(:job_not_found) unless Job.exists(values[:id_vaga])
  end
end
