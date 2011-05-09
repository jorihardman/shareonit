Neighborly::Application.routes.draw do
  post 'feedback/submit_feedback', :as => :submit_feedback
	get 'feedback' => 'feedback#index'
	get 'application' => 'home#application', :as => :application_js

  resources :messages, :communities, :users

  resources :postings do
    member do
      post 'email'
    end
    
    collection do
      get 'services/inventory' => 'postings#services_inventory'
      get 'services/requests' => 'postings#services_requests'
      get 'products/inventory' => 'postings#products_inventory'
      get 'products/requests' => 'postings#products_requests'
      get 'my_stuff/requests' => 'postings#my_requests', :as => 'my_requests'
      get 'my_stuff/inventory' => 'postings#my_inventory', :as => 'my_inventory'
    end
  end

  resource :session, :to => 'user_sessions'
  match '/my_account' => 'users#my_account', :as => 'my_account'
  #match '/auth/facebook/callback' => 'sessions#create'
  #match '/signout' => 'sessions#destroy', :as => :signout

  match '/home/index', :as => 'home'
  match '/home/about', :as => 'about'
  match '/home/contact_us', :as => 'contact_us'

  root :to => 'postings#products_requests'
end

