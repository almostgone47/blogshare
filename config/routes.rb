Rails.application.routes.draw do
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/pages/about' => 'pages#about'
  resources :articles
  resources :categories
  resources :users, except: [:new]
  get 'signup' => "users#new"
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  delete 'logout' => "sessions#destroy"
  get 'logout' => "sessions#destroy"
  resources :article_categories, except: [:new, :update, :create, :destroy, :edit]
end
