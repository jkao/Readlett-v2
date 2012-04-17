Readlett::Application.routes.draw do
  root :to => "home#index"

  # Home Pages
  match "/index" => "home#index", :as => :index
  match "/feed" => "home#index", :as => :feed
  match "/about" => "home#about", :as => :about
  match "/faq" => "home#legal", :as => :faq

  # Authentication
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/login" => "sessions#new", :as => :login
  match "/logout" => "sessions#destroy"

  # Users
  match "/me" => "users#me", :as => :me

  # Bookmarks
  resources :bookmarks do
    member do
      post :like
      post :unlike
      post :follow
      post :unfollow
      post :update_position
      get :redirect
    end

    collection do
      get :search
      get :popular
    end
  end

  # Tags
  resources :tags

  # Bookmarklet

  # Default route
  # match '/:controller(/:action(/:id))'

end
