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
  match "/logout" => "sessions#destroy"

  # Users
  match "/me" => "users#me"

  # Bookmarks
  resources :bookmarks

  # Categories
  match "/tags" => "categories#index", :as => :categories
  match "/tags/:query" => "categories#query", :as => :categories_query

  # Bookmarklet Subdomain

  # Default route
  # match '/:controller(/:action(/:id))'

end
