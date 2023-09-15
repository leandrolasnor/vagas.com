# frozen_string_literal: true

class CreatePerson::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:person_created]
  include Dry.Types()
  extend  Dry::Initializer

  register_event 'person.created'

  option :model, type: Interface(:create), default: -> { CreatePerson::Model::Person }, reader: :private

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
