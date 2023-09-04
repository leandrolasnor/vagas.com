# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe PeopleController do
  subject(:api_request) { |example| submit_request(example.metadata) }

  let(:dijkstra) do
    Dijkstra.new(
      [
        ['A', 'B', 5],
        ['B', 'C', 7],
        ['C', 'E', 4],
        ['E', 'D', 10],
        ['D', 'B', 3],
        ['D', 'F', 8]
      ]
    )
  end

  path '/v1/pessoas' do
    post('create person') do
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          profissao: { type: :string },
          localizacao: { type: :string },
          nivel: { type: :integer }
        },
        required: %w[nome profissao localizacao nivel]
      }

      response(201, 'successful') do
        context 'when a valid request is made' do
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

          before do
            allow(Rails.cache).to receive(:fetch).with(:dijkstra).and_return(dijkstra)
            api_request
          end

          it 'must be able to create a new person' do
            expect(response).to have_http_status(:created)
            expect(json_body).to match(expected_body)
          end
        end
      end

      response 422, 'Unprocessable Entity' do
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

          before do
            allow(Rails.cache).to receive(:fetch).with(:dijkstra).and_return(dijkstra)
            api_request
          end

          it 'must be able to get a error message about nivel field' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(json_body).to match(expected_body)
          end
        end
      end
    end
  end
end
