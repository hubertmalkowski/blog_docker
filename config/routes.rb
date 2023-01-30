Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :articles
  end

  scope module: 'admin' do
    resources :articles, only: [:show, :index] do
      resources :comments
    end
  end

end
