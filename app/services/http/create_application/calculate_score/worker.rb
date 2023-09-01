# frozen_string_literal: true

class Http::CreateApplication::CalculateScore::Worker
  include Sidekiq::Worker

  def perform(application_id)
    CalculateScore::Monad.new(id: application_id).() do
      _1.failure do |e|
        Rails.logger.error(e)
      end
    end
  end
end
