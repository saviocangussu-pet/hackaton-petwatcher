Rails.application.routes.draw do
  devise_for :people
  devise_scope :person do
    root to: 'devise/sessions#new'
  end

  # resources :pets

  resource :person, only: %i[edit update], controller: 'person' do
    get 'me', to: 'person#show', on: :collection

    scope module: :person do
      collection do
        resources :pets, as: :pets
        resources :sitter_services, as: :sitter_services
      end
    end
  end

  resources :reviews

  get 'sitter/:id', to: 'sitters#show', as: 'sitter'
  get 'sitter/:sitter_id/reviews/new', to: 'reviews#new', as: 'new_sitter_review'
  post 'sitter/:sitter_id/reviews', to: 'reviews#create', as: 'sitter_reviews'
  post 'sitter/:id/schedule', to: 'sitters#schedule', as: 'sitter_schedule'

  get 'dashboard', to: 'home#dashboard'
  get 'home', to: 'home#home'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :pet_sitter do
    get '/', to: 'home#index'
    get 'owner/:id', to: 'owners#show', as: 'owner'
    resources :pets, only: %i[show]
  end
end
