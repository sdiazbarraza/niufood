Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :devices, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
  root 'dashboard#index' 
  
  get '/registers', to: 'register#index'
end
