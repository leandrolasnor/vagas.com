# frozen_string_literal: true

class CalculateScore::Monad
  include Dry::Monads[:result, :try]
  include Dry::Events::Publisher
  extend  Dry::Initializer

  param :id

  option :model, default: -> { CalculateScore::Model::Application }
  option :event, default: -> { 'calculated_score' }

  def call
    Try[StandardError] do
      application.score!
      publish(event, application: application)
      application
    end
  end

  private

  def application
    Try[ActiveRecord::RecordNotFound] do
      model.find(id)
    end
  end
end
