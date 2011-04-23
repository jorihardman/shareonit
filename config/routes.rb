Neighborly::Application.routes.draw do
  resources :messages, :communities, :users

  resources :postings do
    collection do
      get 'services/inventory' => 'postings#services_inventory'
      get 'services/requests' => 'postings#services_requests'
      get 'products/inventory' => 'postings#products_inventory'
      get 'products/requests' => 'postings#products_requests'
      get 'my/requests' => 'postings#my_requests'
      get 'my/inventory' => 'postings#my_inventory'
    end

    member do
      post 'offer' => 'offers#create'
      get 'offer' => 'offers#new'
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

