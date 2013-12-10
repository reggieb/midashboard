Midashboard::Application.routes.draw do

  root to: 'dashboards#index'
  
  resources :dashboards

  resources :widgets

end
