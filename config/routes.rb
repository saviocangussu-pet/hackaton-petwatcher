Rails.application.routes.draw do
  devise_for :people
  devise_scope :person do
    root to: 'devise/sessions#new'
  end

  resources :pets

  resource :person, only: %i[] do
    get 'me', to: 'person#show', on: :collection

    scope module: :person do
      resources :pets, as: :pets
      resources :sitter_services, as: :sitter_services
    end
  end

  get 'sitter/:id', to: 'sitter#show', as: 'sitter'

  resource :person, only: %i[show edit update]

  get 'dashboard', to: 'home#dashboard'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
