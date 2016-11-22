Reading::Engine.routes.draw do
  get 'dashboard' => 'home#dashboard'
  resources :notes

  root 'home#index'
end
