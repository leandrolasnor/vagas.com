# frozen_string_literal: true

class V1::JobsController < V1::BaseController
  def create
    resolve(**Http::CreateJob::Service.(params))
  end
end
