Reading::Engine.routes.draw do


  scope '/:locale' do
    get 'pages/:id/*name', to: 'pages#show', as: :page

    resources :notes, except: [:show] do
      collection do
        get 'hot'
        get 'latest'
      end
    end

    resources :books, only: [:index, :show, :destroy] do
      collection do
        get 'hot'
      end
    end

    resources :favorites, only: [:index, :create, :destroy]
  end

  root 'books#hot'
end
