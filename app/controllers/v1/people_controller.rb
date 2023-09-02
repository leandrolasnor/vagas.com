# frozen_string_literal: true

class V1::PeopleController < V1::BaseController
  def create
    status, content, serializer = Http::CreatePerson::Service.(create_params)
    render json: content, status: status, serializer: serializer
  end

  private

  def create_params
    params.permit(
      :nome,
      :profissao,
      :localizacao,
      :nivel
    )
  end
end
