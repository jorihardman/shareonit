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
      get 'inventory' => 'postings#inventory'
      get 'requests' => 'postings#requests'
      get 'my_stuff' => 'postings#my_stuff'
    end
  end

  resource :session, :to => 'user_sessions'
  match '/my_account' => 'users#my_account', :as => 'my_account'

  match '/home/index', :as => 'home'
  match '/home/about', :as => 'about'
  match '/home/contact_us', :as => 'contact_us'

  root :to => 'postings#requests'
end

