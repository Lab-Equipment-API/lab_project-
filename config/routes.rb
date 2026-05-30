Rails.application.routes.draw do
  resources :categories

  get "up" => "rails/health#show", as: :rails_health_check
end