# frozen_string_literal: true

class V1::ApplicationsController < V1::BaseController
  def create
    status, content, serializer = Http::CreateApplication::Service.(create_params)
    render json: content, status: status, serializer: serializer
  end

  private

  def create_params
    params.permit(:vaga_id, :pessoa_id)
  end
end
