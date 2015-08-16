Rails.application.routes.draw do
  get    '/auth/github/callback', to: 'sessions#create'
  delete 'logout',                to: 'sessions#destroy'
  get    '/auth/github',          as: :login
  get    '/dashboard',            to: 'dashboard#show'
  root   'home#show'
end

