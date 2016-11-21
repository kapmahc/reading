Reading::Engine.routes.draw do
  root to: 'home#index'
  resources :notes

end
