# frozen_string_literal: true

class Ranking::Monad
  include Dry::Monads[:result]
  extend  Dry::Initializer

  option :model, default: -> { Ranking::Model::Application }
  option :limit, default: -> { 25 }
  option :offset, default: -> { 0 }

  def call(job_id)
    Success(
      model.
        includes(:person).
        where(job_id: job_id).
        limit(limit).
        offset(offset).
        order(score: :desc)
    )
  end
end
