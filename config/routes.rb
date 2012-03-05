Readlett::Application.routes.draw do
  root :to => "home#index"

  # Home Pages
  match "/index" => "home#index", :as => :index
  match "/about" => "home#about", :as => :about

  # Authentication
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"

  # Default route
  # match '/:controller(/:action(/:id))'

end
