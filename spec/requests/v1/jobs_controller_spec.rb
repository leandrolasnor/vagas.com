# frozen_string_literal: true

require 'rails_helper'
module V1
  RSpec.describe JobsController do
    describe 'POST /v1/vagas' do
      context 'when params are correct' do
        let(:params) do
          {
            empresa: 'Nome da Empresa',
            titulo: 'Titulo da Vaga',
            descricao: 'Descricao da Vaga',
            localizacao: 'Remoto',
            nivel: 2
          }
        end

        let(:expected_body) do
          {
            empresa: 'Nome da Empresa',
            titulo: 'Titulo da Vaga',
            descricao: 'Descricao da Vaga',
            localizacao: 'Remoto',
            nivel: CreateJob::Model::Job.levels.keys[params[:nivel]]
          }
        end

        before { post(v1_vagas_path, params: params, as: :json) }

        it 'must be able to create a new job' do
          expect(response).to be_successful
          expect(json_body).to match(expected_body)
        end
      end

      context 'when nivel param is invalid' do
        let(:params) do
          {
            empresa: 'Nome da Empresa',
            titulo: 'Titulo da Vaga',
            descricao: 'Descricao da Vaga',
            localizacao: 'Remoto',
            nivel: 200
          }
        end

        let(:expected_body) do
          {
            nivel: ["must be one of: trainee, junior, full, senior, specialist"]
          }
        end

        before { post(v1_vagas_path, params: params, as: :json) }

        it 'must be able to get a error message about nivel field' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to match(expected_body)
        end
      end
    end
  end
end
