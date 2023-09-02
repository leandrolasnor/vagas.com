# frozen_string_literal: true

class CreateApplication::Contract < CreateApplication::Macros

  params do
    required(:id_vaga).filled(:integer)
    required(:id_pessoa).filled(:integer)
  end

  rule(:id_vaga).validate(:exists_job)
  rule(:id_pessoa).validate(:exists_person)
end
