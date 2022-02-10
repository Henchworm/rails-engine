Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/api/v1/merchants/:id/items', to: 'api/v1/merchant_items#index'

  namespace :api do
    namespace :v1 do
      get '/merchants/find/', to: 'merchants_find#show'
      get '/merchants/find_all/', to: 'merchants_find#index'
      get '/items/find_all', to: 'items_find#index'
      get '/items/find', to: 'items_find#show'

      resources :merchants, only: [:index] do
        resources :items, controller: 'merchant_items'
      end
      resources :items do
        resources :merchant, only: [:index], controller: 'item_merchant'
      end
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy, :update]
    end
  end
end
