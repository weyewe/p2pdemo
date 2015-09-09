Rails.application.routes.draw do  
      
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # root 'home#dashboard'
  root 'welcome#index'
  
  resources :users
  resources :borrower_profiles
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  get '/dashboard' => 'home#dashboard',  :as => :dashboard
  get '/borrower_application' => 'home#borrower_application',  :as => :borrower_dashboard
   
 
  
end
