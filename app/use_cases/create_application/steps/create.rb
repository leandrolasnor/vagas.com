# frozen_string_literal: true

class CreateApplication::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:application_created]
  extend  Dry::Initializer

  register_event 'application.created'

  option :model, default: -> { CreateApplication::Model::Application }

  def call(params)
    model.create do
      _1.job_id = params[:id_vaga]
      _1.person_id = params[:id_pessoa]
      publish('application.created', application: _1)
    end
  end
end
