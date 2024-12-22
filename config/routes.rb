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
    root 'users#index'
    resources :users, only: [:show, :index, :update]
    resources :genres, only: [:index, :create, :destroy, :edit, :update] 
    resources :recipe_comments, only: [:index]     # 全コメントの一覧用
    resources :recipe_reviews, only: [:index]      # 全レビューの一覧用
    resources :recipes, only: [:show, :index, :destroy] do
      resources :recipe_comments, only: [:destroy]
      resources :recipe_reviews, only: [:destroy]
    end
  end

  # エンドユーザー用
  scope module: :public do
    root 'homes#top'
    
    get 'homes/about', to: 'homes#about', as: :about
    get 'search', to: 'searches#search', as: :search  
    
    resources :recipes do
      resources :recipe_comments, only: [:create, :destroy]
      resource :recipe_favorite, only: [:create, :destroy]
      resources :recipe_reviews, only: [:create, :edit, :update, :destroy]
    end
    
    resources :users, only: [:show, :edit, :update, :withdraw] do
      member do
        patch 'withdraw'
      end
    end
  end
end