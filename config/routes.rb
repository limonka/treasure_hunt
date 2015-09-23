Rails.application.routes.draw do
  resources :treasure_hunt, only: [:create, :index]

  root 'treasure_hunt#index'
end
