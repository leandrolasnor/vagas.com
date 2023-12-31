# frozen_string_literal: true

class CalculateScore::Monad
  include Dry::Monads[:result, :try]
  include Dry::Events::Publisher[:calculate_score]
  include Dry.Types()
  extend  Dry::Initializer

  register_event 'score.calculated'

  option :model, type: Interface(:find), default: -> { CalculateScore::Model::Application }, reader: :private

  def call(id)
    Try(ActiveRecord::RecordNotFound) { model.find(id) }.
      fmap { _1.score! && _1 }.
      fmap { publish('score.calculated', application: _1) && _1 }
  end
end
