# frozen_string_literal: true

class CalculateScore::Monad
  include Dry::Monads[:try]
  include Dry::Events::Publisher[:calculate_score]
  extend  Dry::Initializer

  EVENT = 'calculated_score'

  register_event EVENT

  param :id

  option :model, default: -> { CalculateScore::Model::Application }

  def call
    res = Try[StandardError] do
      application.score!
      publish(EVENT, application: application)
      application
    end

    res.error? ? Failure(res.exception.message) : res
  end

  private

  def application
    res = Try[ActiveRecord::RecordNotFound] do
      model.find(id)
    end

    res.error? ? Failure(res.exception.message) : res.value!
  end
end
