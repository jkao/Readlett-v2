Readlett::Application.routes.draw do
  root :to => "home#index"

  # Home Pages
  match "/index" => "home#index", :as => :index
  match "/explore" => "home#explore", :as => :explore
  match "/about" => "home#about", :as => :about
  match "/faq" => "home#faq", :as => :faq

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
      post :report
      get :redirect
      get :share
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
