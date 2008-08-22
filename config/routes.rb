ActionController::Routing::Routes.draw do |map|
  map.resources :sites, :member => {:generate => :post, :clone => :get, :create_clone => :post} do |site|
    site.resources :models do |model|
      model.resources :columns
      model.resources :associations
      model.resources :validations
    end
  end

  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.signup   '/signup',   :controller => 'users',    :action => 'new'
  
  map.resources :users

  map.resource :session

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.root :controller => 'index'
end
