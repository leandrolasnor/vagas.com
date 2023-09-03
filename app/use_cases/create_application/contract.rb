# frozen_string_literal: true

class CreateApplication::Contract < ApplicationContract
  params do
    required(:id_vaga).filled(:integer)
    required(:id_pessoa).filled(:integer)
  end

  register_macro(:exists_person) do
    exists = CreateApplication::Model::Person.exists?(values[:id_pessoa])
    key(:id_pessoa).failure(:person_not_found) unless exists
  end

  register_macro(:exists_job) do
    exists = CreateApplication::Model::Job.exists?(values[:id_vaga])
    key(:id_vaga).failure(:job_not_found) unless exists
  end

  rule(:id_vaga).validate(:exists_job)
  rule(:id_pessoa).validate(:exists_person)
end
