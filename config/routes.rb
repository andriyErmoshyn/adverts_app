Rails.application.routes.draw do
  root 'ads#index'

  resources :members
  resources :ads do
    resources :comments
  end
  
  resources :password_resets, only: [ :new, :create, :edit, :update ]

  get 'signup'    => 'members#new'
  get 'login'       => 'sessions#new'
  post 'login'      => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create'
  
end
