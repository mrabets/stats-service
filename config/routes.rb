Rails.application.routes.draw do
  resources :visits, only: [:index]

  root 'visits#index'
end
