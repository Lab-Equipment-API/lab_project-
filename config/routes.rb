Rails.application.routes.draw do
  # Define standard RESTful routes for Equipment and Maintenance Records
  resources :equipment
  resources :maintenance_records

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end