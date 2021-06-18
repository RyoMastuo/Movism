Rails.application.routes.draw do
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :update, :edit] do
    member do
      get :likes
      get :postings
    end
  end
  
  resources :rooms, only: [:show, :new, :create, :update, :edit]
  resources :posts, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
