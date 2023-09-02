# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::JobsController do
  context 'with api version 1' do
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
            nivel: 2
          }
        end

        before { post(v1_vagas_path, params: params, as: :json) }

        it 'must be able to create a new job' do
          expect(response).to be_successful
          expect(json_body).to match(expected_body)
        end
      end
    end
  end
end
