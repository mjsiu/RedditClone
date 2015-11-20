Rails.application.routes.draw do
  resources :users

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy] do
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [:edit, :update, :destroy, :show]

end
