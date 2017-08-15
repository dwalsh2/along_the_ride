Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "routes#index"
  # Routes for the Waypoint resource:
  # CREATE
  get "/waypoints/new", :controller => "waypoints", :action => "new"
  post "/create_waypoint", :controller => "waypoints", :action => "create"

  # READ
  get "/waypoints", :controller => "waypoints", :action => "index"
  get "/waypoints/:id", :controller => "waypoints", :action => "show"

  # UPDATE
  get "/waypoints/:id/edit", :controller => "waypoints", :action => "edit"
  post "/update_waypoint/:id", :controller => "waypoints", :action => "update"

  # DELETE
  get "/delete_waypoint/:id", :controller => "waypoints", :action => "destroy"
  #------------------------------

  # Routes for the Business resource:
  # CREATE
  get "/businesses/new", :controller => "businesses", :action => "new"
  post "/create_business", :controller => "businesses", :action => "create"

  # READ
  get "/businesses", :controller => "businesses", :action => "index"
  get "/businesses/:id", :controller => "businesses", :action => "show"

  # UPDATE
  get "/businesses/:id/edit", :controller => "businesses", :action => "edit"
  post "/update_business/:id", :controller => "businesses", :action => "update"

  # DELETE
  get "/delete_business/:id", :controller => "businesses", :action => "destroy"
  #------------------------------

  # Routes for the Route resource:
  # CREATE
  get "/routes/new", :controller => "routes", :action => "new"
  post "/create_route", :controller => "routes", :action => "create"

  # READ
  get "/routes", :controller => "routes", :action => "index"
  get "/routes/:id", :controller => "routes", :action => "show"

  # UPDATE
  get "/routes/:id/edit", :controller => "routes", :action => "edit"
  post "/update_route/:id", :controller => "routes", :action => "update"

  # DELETE
  get "/delete_route/:id", :controller => "routes", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
