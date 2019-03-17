Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'events#index'
  resources :events, only: [:index]
  resources :new_events, only: [:index]
  resources :topics, only: :show do
    resources :posts, only: [:create]
  end
  resources :new_event_marks, only: [:update]
  resources :users, only: :create

  resources :city_search_results, only: [:index]
  resources :tag_search_results, only: [:index]

  resources :filters, only: [:destroy]
  resources :filtered_events_lists, only: [:create, :update]
end
