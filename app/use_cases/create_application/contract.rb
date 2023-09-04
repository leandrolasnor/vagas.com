# frozen_string_literal: true

class CreateApplication::Contract < ApplicationContract
  params do
    required(:id_vaga).filled(:integer)
    required(:id_pessoa).filled(:integer)
  end

  register_macro(:exists_person) do
    exists_person = CreateApplication::Model::Person.exists?(values[:id_pessoa])
    key(:id_pessoa).failure(:person_not_found) unless exists_person
  end

  register_macro(:exists_job) do
    exists_job = CreateApplication::Model::Job.exists?(values[:id_vaga])
    key(:id_vaga).failure(:job_not_found) unless exists_job
  end

  rule(:id_vaga).validate(:exists_job)
  rule(:id_pessoa).validate(:exists_person)

  register_macro(:exists_application) do
    exists_application = CreateApplication::Model::Application.exists?(
      job_id: values[:id_vaga],
      person_id: values[:id_pessoa]
    )

    key(:application).failure(:already_applied) if exists_application
  end

  rule(:id_vaga, :id_pessoa).validate(:exists_application)
end
