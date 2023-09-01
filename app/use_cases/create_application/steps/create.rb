# frozen_string_literal: true

class CreateApplication::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher
  extend  Dry::Initializer

  option :model, default: -> { Application }
  option :event, default: -> { 'created' }

  def call(params)
    created = model.create do
      _1.job_id = params[:id_vaga]
      _1.person_id = params[:id_pessoa]
    end
    publish(event, application: created)
    created
  end
end
