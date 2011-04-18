Neighborly::Application.routes.draw do
  resources :messages, :communities, :users, :postings

  resource :session, :to => 'user_sessions'
  match '/my_account' => 'users#my_account', :as => 'my_account'
  #match '/auth/facebook/callback' => 'sessions#create'
  #match '/signout' => 'sessions#destroy', :as => :signout

  match '/home/index', :as => 'home'
  match '/home/about', :as => 'about'
  match '/home/contact_us', :as => 'contact_us'

  root :to => 'postings#index'
end

