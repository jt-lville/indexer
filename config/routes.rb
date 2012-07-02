OrchiveApp::Application.routes.draw do	
  resources :preferences

  devise_for :linked_accounts

  resources :comments
  
    devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "join" }, :controllers => {:registrations => 'users/registrations', :sessions=> 'users/sessions', :passwords=>'users/passwords'}
	
	resources :beta_pages
	resources :pages
	
	resources :users do
		resources :comments
		resources :posts
    resources :preferences
    resources :messages
    
    member do 
      get :following, :followers
    end 
    
	end
  
  resources :preferences do 
    collection do
      post "tag_with"
      post "clear_tag_list_and_preferences"
      post "make_feed_preference"    
    end
  end
	
	resources :posts do
    resources :comments
    
    collection do
    post "vote_up"
    post "vote_down"
    end
    
    #Jon's modifications
    #match "vote_up", :on => :collection
    #match "vote_down", :on => :collection
    #post 'vote_up', :on => :member
    #post 'vote_down', :on => :collection
    
#       member do
#       post 'vote_up'
#       delete 'destroy'
#    end
  end
  
  resources :comments do
     collection do
      post "vote_up"
      post "vote_down"
      post "reply"
      end
  end
  
	root :to => 'beta_pages#index'
	  
  match '/messages' => 'messages#index'
  post 'pusher/auth' #for pusher

  match '/contact' => 'Pages#Contact'
  match '/about' => 'Pages#About'
  match '/help' => 'Pages#Help'
  match '/command' => 'Pages#Command'
  match '/privacy' => 'Pages#Privacy'
  match '/terms' => 'Pages#Terms'
  match '/future' => 'Pages#Future'
  match '/FAQ' => 'Pages#FAQ'
  match '/dashboard' => 'users#adminUI'

  
end