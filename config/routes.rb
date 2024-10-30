Rails.application.routes.draw do
  devise_for :people
  devise_scope :person do
    root to: 'devise/sessions#new'
  end

  resources :pets

  resources :person do
    resources :pets, module: :person
    resources :sitter_services, module: :person
  end

  resource :person, only: %i[show edit update]

  get 'dashboard', to: 'home#dashboard'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
