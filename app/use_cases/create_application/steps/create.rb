# frozen_string_literal: true

class CreateApplication::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:application_created]
  include Dry.Types()
  extend  Dry::Initializer

  register_event 'application.created'

  option :model, type: Interface(:create), default: -> { CreateApplication::Model::Application }

  def call(params)
    created = model.create do
      _1.job_id = params[:id_vaga]
      _1.person_id = params[:id_pessoa]
    end
    publish('application.created', application: created)
    created
  end
end
