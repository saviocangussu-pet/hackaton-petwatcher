Rails.application.routes.draw do
  devise_for :people

  devise_scope :person do
    root to: "devise/sessions#new"
  end

  resources :pets

  resources :person do
    resources :pets, module: :person
  end

  resource :person, only: [:show, :edit, :update]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
