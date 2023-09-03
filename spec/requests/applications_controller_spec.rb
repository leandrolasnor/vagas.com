# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe ApplicationsController do
  subject(:api_request) { |example| submit_request(example.metadata) }

  path '/v1/candidaturas' do
    post('create application') do
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          id_vaga: { type: :integer },
          id_pessoa: { type: :integer }
        },
        required: %w[id_vaga id_pessoa]
      }

      response(201, 'successful') do
        context 'when a valid request is made' do
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
            api_request
          end

          it 'must be able to create a new application' do
            expect(response).to have_http_status(:created)
            expect(json_body).to match(expected_body)
            expect(Http::CreateApplication::CalculateScore::Job).to have_received(:perform_later)
          end
        end
      end

      response 422, 'Unprocessable Entity' do
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
            api_request
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
end
