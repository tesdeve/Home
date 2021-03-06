Rails.application.routes.draw do

  resources :invites
  root 'pages#home'
  
  resources :buildings do 
    resources :engagements
  end
  #resources :engagements
  resources :contactinfos
  

  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users,  only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
