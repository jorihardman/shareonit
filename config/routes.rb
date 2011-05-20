Neighborly::Application.routes.draw do
  resources :users
  
  resources :communities do
    member do
      post 'request'
      get 'add_users' => 'communities#edit'
      post 'add_users' => 'communities#update'
    end
  end

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
  
  post 'feedback/submit_feedback', :as => :submit_feedback
	get 'feedback' => 'feedback#index'
	
	get 'application' => 'home#application', :as => :application_js
  
  root :to => 'user_sessions#new'
end

