# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: redirect('rails/info/routes')

  namespace :v1 do
    post :vagas, to: 'jobs#create'
    post :pessoas, to: 'peoples#create'
    post :candidaturas, to: 'application#create'

    get '/vagas/:vaga_id/candidaturas/ranking', to: 'jobs#show_applications', as: :ranking
  end

  get '/health', to: proc { [200, {}, ['success']] }
  match '*path', via: :all, to: proc { [404, {}, nil] }
end
