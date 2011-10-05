Shareonit::Application.routes.draw do
  
  resources :users
  
  resources :communities do
    resources :memberships do
      member do
        get 'accept'
      end
    end
    
    resources :invitations do
      member do
        get 'accept'
      end
    end
  end

  resources :postings do
    member do
      post 'email'
    end
    
    collection do
      get 'inventory' => 'postings#index', :scope => 'inventory'
      get 'requests' => 'postings#index', :scope => 'requests'
      get 'my_stuff' => 'postings#index', :scope => 'my_stuff'
    end
  end

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy'

  match 'about' => 'home#about', :as => 'about'
  match 'contact' => 'home#contact', :as => 'contact'
  
  post 'feedback/submit_feedback', :as => :submit_feedback
	get 'feedback' => 'feedback#index'
  
  root :to => 'user_sessions#new'
  
end
