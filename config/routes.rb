Rails.application.routes.draw do  
      
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # root 'home#dashboard'
  root 'welcome#index'
  get 'login_with_facebook' => 'welcome#login_with_facebook', :as => :login_with_facebook
  
  resources :users 
  resources :loan_requests
  # match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  # get '/dashboard' => 'home#dashboard',  :as => :dashboard
  # get '/borrower_application' => 'home#borrower_application',  :as => :borrower_dashboard
  
  get '/borrower/profile' => 'users#edit_borrower_profile', :as => :edit_borrower_profile
  post '/borrower/profile' => 'users#update_borrower_profile', :as => :update_borrower_profile
  
  # get '/borrower/employment_and_education' => 'users#edit_employment_education', :as => :edit_borrower_employment_education
   
 
  
end
