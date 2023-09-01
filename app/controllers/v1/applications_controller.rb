# frozen_string_literal: true

class V1::ApplicationsController < V1::BaseController
  def create
    resolve(**Http::CreateApplication::Service.(params))
  end
end
