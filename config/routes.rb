# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: proc { [200, {}, ['success']] }

  scope '/v1' do
    post :vagas, to: 'jobs#create'
    post :pessoas, to: 'people#create'
    post :candidaturas, to: 'applications#create'

    get '/vagas/:job_id/candidaturas/ranking', to: 'jobs#ranking', as: :ranking
  end

  match '*path', via: :all, to: proc { [404, {}, nil] }
end
