# frozen_string_literal: true

class Http::CreateApplication::CalculateScore::Job < ApplicationJob
  queue_as :default

  def perform(id)
    res = CalculateScore::Monad.new.(id)
    Rails.logger.error(res.exception) if res.failure?
  end
end
