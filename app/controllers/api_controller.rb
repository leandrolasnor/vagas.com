# frozen_string_literal: true

class ApiController < ActionController::API
  def not_found
    head :not_found
  end
end
