# frozen_string_literal: true

class CreatePerson::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:person_created]
  extend  Dry::Initializer

  register_event 'person.created'

  option :model, default: -> { CreatePerson::Model::Person }

  def call(params)
    model.create do
      _1.name = params[:nome]
      _1.profession = params[:profissao]
      _1.location = params[:localizacao]
      _1.level = params[:nivel]
      publish('person.created', person: _1)
    end
  end
end
