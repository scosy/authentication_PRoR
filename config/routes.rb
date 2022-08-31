Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[destroy]
  resources :dashboards, only: %i[index]
  resources :logins, only: %i[new create destroy]
  resources :registrations, only: %i[new create]
end
