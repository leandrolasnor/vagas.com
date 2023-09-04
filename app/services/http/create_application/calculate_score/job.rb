# frozen_string_literal: true

class Http::CreateApplication::CalculateScore::Job
  @queue = :dev_default

  def self.perform(id)
    res = CalculateScore::Monad.new.(id)
    Rails.logger.error(res.exception) if res.failure?
  end
end
