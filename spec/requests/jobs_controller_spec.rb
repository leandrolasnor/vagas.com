# frozen_string_literal: true

require 'rails_helper'
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

      before { post(vagas_path, params: params, as: :json) }

      it 'must be able to create a new job' do
        expect(response).to have_http_status(:created)
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

      before { post(vagas_path, params: params, as: :json) }

      it 'must be able to get a error message about nivel field' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to match(expected_body)
      end
    end
  end

  describe 'GET /v1/vagas/:job_id/candidaturas/ranking' do
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
        get(ranking_path(jobs.first.id))
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
        get(ranking_path(jobs.first.id))
      end

      it 'must be able to get a empty array as response' do
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq(expected_body)
      end
    end

    context 'when job not exist' do
      let(:job_id) { 0 }
      let(:expected_body) { [] }

      before { get(ranking_path(job_id)) }

      it 'must be able to get a empty array on response' do
        expect(response).to have_http_status(:ok)
        expect(json_body).to match(expected_body)
      end
    end
  end
end
