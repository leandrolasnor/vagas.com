# frozen_string_literal: true

class CreateApplication::Steps::Create
  include Dry::Monads[:try]
  include Dry::Events::Publisher[:application_created]
  extend  Dry::Initializer

  register_event 'created'

  option :model, default: -> { Application }

  def call(params)
    res = Try[StandardError] do
      created = model.create do
        _1.job_id = params[:id_vaga]
        _1.person_id = params[:id_pessoa]
      end
      publish('created', application: created)
      created
    end

    res.error? ? Failure(res.exception.message) : res
  end
end
