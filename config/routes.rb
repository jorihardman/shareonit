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

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  match 'about' => 'home#about', :as => 'about'
  match 'contact' => 'home#contact', :as => 'contact'
  
  root :to => 'user_sessions#new'
end

