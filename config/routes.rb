Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'events#index'
  resources :events, only: [:index, :show] do
    get 'new_events', on: :collection
  end
  resources :topics, only: :show do
    resources :posts, only: [:create]
  end
  resources :users, only: :create

  resources :cities, only: [] do
    get 'search', on: :collection
  end

  resources :tags, only: [] do
    get 'search', on: :collection
  end

  resources :filters, only: [:create, :show, :destroy]
end
