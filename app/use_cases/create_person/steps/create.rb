# frozen_string_literal: true

class CreatePerson::Steps::Create
  include Dry::Monads[:try]
  include Dry::Events::Publisher[:person_created]
  extend  Dry::Initializer

  register_event 'person.created'

  option :model, default: -> { CreatePerson::Model::Person }

  def call(params)
    res = Try[] do
      created = model.create(params)
      publish('person.created', person: created)
      created
    end

    res.error? ? Failure(res.exception.message) : res
  end
end
