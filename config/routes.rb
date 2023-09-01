# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: redirect('rails/info/routes')

  namespace :v1 do
    post :vagas, to: 'v1::jobs#create'
    post :pessoas, to: 'v1::peoples#create'
    post :candidaturas, to: 'v1::application#create'

    namespace :vagas do
      resources :candidaturas, on: :member do
        get :ranking, to: 'v1::jobs#show_applications'
      end
    end
  end

  get '/health', to: proc { [200, {}, ['success']] }
  match '*path' => 'api#not_found', via: :all
end
