# frozen_string_literal: true

class CreatePerson::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:person_created]
  extend  Dry::Initializer

  register_event 'person.created'

  option :model, default: -> { CreatePerson::Model::Person }

  def call(params)
    created = model.create do
      _1.name = params[:nome]
      _1.profession = params[:profissao]
      _1.location = params[:localizacao]
      _1.level = params[:nivel]
    end
    publish('person.created', person: created)
    created
  end
end
