# frozen_string_literal: true

class Http::CreateApplication::CalculateScore::Job < ApplicationJob
  queue_as :default

  def perform(id)
    CalculateScore::Monad.new.(id).failure { Rails.logger.error(_1) }
  end
end
