# frozen_string_literal: true

require 'rails_helper'
module V1
  RSpec.describe ApplicationsController do
    describe 'POST /v1/candidaturas' do
      context 'when params are correct' do
        let(:job) { create(:job) }
        let(:person) { create(:person) }

        let(:params) do
          {
            id_vaga: job.id,
            id_pessoa: person.id
          }
        end

        let(:expected_body) do
          {
            nome: person.name,
            descricao: job.description
          }
        end

        before do
          allow(Http::CreateApplication::CalculateScore::Job).to receive(:perform_later)
          post(v1_candidaturas_path, params: params, as: :json)
        end

        it 'must be able to create a new application' do
          expect(response).to be_created
          expect(json_body).to match(expected_body)
          expect(Http::CreateApplication::CalculateScore::Job).to have_received(:perform_later)
        end
      end

      context 'when the entities are not found' do
        let(:params) do
          {
            id_vaga: 0,
            id_pessoa: 0
          }
        end

        let(:expected_body) do
          {
            id_vaga: ["Job not found!"],
            id_pessoa: ["Person not found!"]
          }
        end

        before do
          allow(Http::CreateApplication::CalculateScore::Job).to receive(:perform_later)
          post(v1_candidaturas_path, params: params, as: :json)
        end

        it 'must be able to get a error message about nivel field' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to match(expected_body)
          expect(Http::CreateApplication::CalculateScore::Job).not_to have_received(:perform_later)
        end
      end
    end
  end
end
