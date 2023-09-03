# frozen_string_literal: true

class ApiController < ActionController::API
  rescue_from StandardError, with: :standard_error

  private

  def standard_error(e)
    Rails.logger.error(e)
    head :internal_server_error
  end
end
