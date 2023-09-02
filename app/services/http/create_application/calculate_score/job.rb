# frozen_string_literal: true

class Http::CreateApplication::CalculateScore::Job < ApplicationJob
  queue_as :default

  def perform(id)
    CalculateScore::Monad.new(id).call.failure { |e| Rails.logger.error(e) }
  end
end
