# frozen_string_literal: true

class CreateJob::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher
  extend  Dry::Initializer

  option :model, default: -> { CreateJob::Model::Job }
  option :event, default: -> { 'job.created' }

  def call(params)
    created = model.create(params)
    publish(event, job: created)
    created
  end
end
