Rails.application.routes.draw do
  resources :categories, only: [:index, :show, :create, :update, :destroy]
  get "up" => "rails/health#check", as: :rails_health_check
end