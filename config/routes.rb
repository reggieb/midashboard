Midashboard::Application.routes.draw do

  devise_for :users

  root to: 'dashboards#index'
  
  resources :dashboards

  resources :widgets

end
