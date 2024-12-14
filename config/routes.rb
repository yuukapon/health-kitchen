Rails.application.routes.draw do
  # 管理者用ルート
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  # エンドユーザー用のdevise
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  
  # 管理者用
  namespace :admin do
    root 'dashboards#index'  
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :index, :update]
    resources :genres, only: [:index, :create, :destroy, :edit, :update] 
    resources :recipes, only: [:show, :index, :destroy] do
      resources :recipe_comments, only: [:destroy]
    end
  end

  # エンドユーザー用
  scope module: :public do
    root 'homes#top'
    
    get 'homes/about', to: 'homes#about', as: :about
    get 'search', to: 'searches#search', as: :search  
    
    resources :recipes, only: [:new, :index, :show, :destroy, :create, :edit, :update] do
      resources :recipe_comments, only: [:create, :destroy]
      resource :recipe_favorite, only: [:create, :destroy]
    end
    
    resources :users, only: [:show, :edit, :update, :withdraw] do
      member do
        patch 'withdraw'
      end
    end
  end
end