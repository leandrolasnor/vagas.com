# frozen_string_literal: true

class CreatePerson::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher
  extend  Dry::Initializer

  option :model, default: -> { CreatePerson::Model::Person }
  option :event, default: -> { 'person.created' }

  def call(params)
    created = model.create(params)
    publish(event, person: created)
    created
  end
end
