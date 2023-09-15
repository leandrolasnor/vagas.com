# frozen_string_literal: true

class CreateJob::Steps::Create
  include Dry::Monads[:result]
  include Dry::Events::Publisher[:job_created]
  include Dry.Types()
  extend Dry::Initializer

  register_event 'job.created'

  option :model, type: Interface(:create), default: -> { CreateJob::Model::Job }, reader: :private

  def call(params)
    created = model.create do
      _1.company = params[:empresa]
      _1.title = params[:titulo]
      _1.description = params[:descricao]
      _1.location = params[:localizacao]
      _1.level = params[:nivel]
    end
    publish('job.created', job: created)
    created
  end
end
