# frozen_string_literal: true

require 'rails_helper'
RSpec.describe PeopleController do
  describe 'POST /v1/pessoas' do
    context 'when params are correct' do
      let(:params) do
        {
          nome: "Nome da Pessoa",
          profissao: "Profissão da Pessoa",
          localizacao: "C",
          nivel: 2
        }
      end

      let(:expected_body) do
        {
          nome: "Nome da Pessoa",
          profissao: "Profissão da Pessoa",
          localizacao: "C",
          nivel: CreatePerson::Model::Person.levels.keys[params[:nivel]]
        }
      end

      before { post(pessoas_path, params: params, as: :json) }

      it 'must be able to create a new person' do
        expect(response).to have_http_status(:created)
        expect(json_body).to match(expected_body)
      end
    end

    context 'when nivel param is invalid' do
      let(:params) do
        {
          nome: "Nome da Pessoa",
          profissao: "Profissão da Pessoa",
          localizacao: "C",
          nivel: Float::INFINITY
        }
      end

      let(:expected_body) do
        {
          nivel: ["must be one of: trainee, junior, full, senior, specialist"]
        }
      end

      before { post(pessoas_path, params: params, as: :json) }

      it 'must be able to get a error message about nivel field' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to match(expected_body)
      end
    end
  end
end
