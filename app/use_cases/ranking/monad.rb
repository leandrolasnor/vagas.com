# frozen_string_literal: true

class Ranking::Monad
  include Dry::Monads[:result, :try]
  extend  Dry::Initializer

  param :job_id

  option :model, default: -> { Ranking::Model::Job }
  option :limit, default: -> { 25 }

  def call
    res = Try[StandardError] do
      job.includes(applications: :person).limit(limit).order(score: :desc)
    end

    res.error? ? Failure(res.exception) : res.value!
  end

  private

  def job
    res = Try[ActiveRecord::RecordNotFound] do
      model.find(job_id)
    end

    res.error? ? Failure(res.exception) : res.value!
  end
end
