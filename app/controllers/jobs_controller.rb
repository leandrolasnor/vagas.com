# frozen_string_literal: true

class JobsController < BaseController
  def create
    status, content, serializer = Http::CreateJob::Service.(create_params)
    render json: content, status: status, serializer: serializer
  end

  def ranking
    status, content, serializer = Http::Ranking::Service.(ranking_params)
    render json: content, status: status, each_serializer: serializer
  end

  private

  def create_params
    params.permit(
      :empresa,
      :titulo,
      :descricao,
      :localizacao,
      :nivel
    )
  end

  def ranking_params
    params.permit(:job_id)
  end
end
