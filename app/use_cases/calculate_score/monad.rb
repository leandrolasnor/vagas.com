# frozen_string_literal: true

class CalculateScore::Monad
  include Dry::Monads[:result, :try]
  include Dry::Events::Publisher[:calculate_score]
  extend  Dry::Initializer

  register_event 'score.calculated'

  option :model, default: -> { CalculateScore::Model::Application }

  def call(id)
    Try(ActiveRecord::RecordNotFound) { model.find(id) }.
      fmap { _1.score! && _1 }.
      fmap { publish('score.calculated', application: _1) && _1 }
  end
end
