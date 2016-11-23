Reading::Engine.routes.draw do

  scope '/:locale' do
    resources :notes do
      collection do
        get 'hot'
        get 'latest'
      end
    end
    resources :books
    resources :favorites
  end

  root 'home#index'
end
