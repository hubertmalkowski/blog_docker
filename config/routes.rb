Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :articles
  end

  resources :articles, only: [:show, :index] do
    resources :comments
  end
end
