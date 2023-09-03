# frozen_string_literal: true

module Types
  include Dry.Types()

  LevelPerson = Types::String.constructor do
    CreatePerson::Model::Person.levels.key(_1)
  end
end

class CreatePerson::Contract < ApplicationContract
  params do
    required(:nome).filled(:string)
    required(:profissao).filled(:string)
    required(:localizacao).filled(:string)
    required(:nivel).type(Types::LevelPerson).value(included_in?: CreatePerson::Model::Person.levels.keys)
  end
end
