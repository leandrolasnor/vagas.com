# frozen_string_literal: true

class ApplicationsController < BaseController
  def create
    status, content, serializer = Http::CreateApplication::Service.(create_params)
    render json: content, status: status, serializer: serializer
  end

  private

  def create_params
    params.permit(:id_vaga, :id_pessoa)
  end
end
