# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe JobsController do
  subject(:api_request) { |example| submit_request(example.metadata) }

  path '/v1/vagas' do
    post('create job') do
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          empresa: { type: :string },
          titulo: { type: :string },
          descricao: { type: :string },
          localizacao: { type: :string },
          nivel: { type: :integer }
        },
        required: %w[empresa titulo descricao localizacao nivel]
      }

      response('201', 'successful') do
        context 'when a valid request is made' do
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

          before { api_request }

          it 'must be able to create a new person' do
            expect(response).to have_http_status(:created)
            expect(json_body).to match(expected_body)
          end
        end
      end

      response '422', 'Unprocessable Entity' do
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

          before { api_request }

          it 'must be able to get a error message about nivel field' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(json_body).to match(expected_body)
          end
        end
      end
    end
  end

  path '/v1/vagas/{job_id}/candidaturas/ranking' do
    # You'll want to customize the parameter types...
    parameter name: 'job_id', in: :path, type: :string, description: 'job_id'

    get('ranking job') do
      response(200, 'successful') do
        let(:job_id) { jobs.first.id }

        context 'when there are applications on data base' do
          let(:jobs) { create_list(:job, 2) }
          let(:people) { create_list(:person, 2) }

          let(:apply_first) do
            create(
              :application,
              job_id: jobs.first.id,
              person_id: people.first.id,
              score: 100
            )
          end

          let(:apply_second) do
            create(
              :application,
              job_id: jobs.first.id,
              person_id: people.second.id,
              score: 50
            )
          end

          let(:expected_body) do
            [
              {
                nome: people.first.name,
                profissao: people.first.profession,
                localizacao: people.first.location,
                nivel: people.first.level,
                score: 100
              },
              {
                nome: people.second.name,
                profissao: people.second.profession,
                localizacao: people.second.location,
                nivel: people.second.level,
                score: 50
              }
            ]
          end

          before do
            apply_first
            apply_second
            api_request
          end

          it 'must be able to get applications in descending order by score' do
            expect(response).to have_http_status(:ok)
            expect(json_body).to eq(expected_body)
          end
        end

        context 'when there are not applications on data base' do
          let(:jobs) { create_list(:job, 2) }
          let(:people) { create_list(:person, 2) }
          let(:expected_body) { [] }

          before do
            jobs
            people
            api_request
          end

          it 'must be able to get a empty array as response' do
            expect(response).to have_http_status(:ok)
            expect(json_body).to eq(expected_body)
          end
        end
      end
    end
  end
end
