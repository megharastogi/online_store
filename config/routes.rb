ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'home', :action => 'show'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'new'
  map.signup '/signup', :controller => 'accounts', :action => 'new'
  map.admins '/admins' , :controller => "admins" , :action => "index"
  map.forgot_password '/forgot_password', :controller => "accounts" , :action => "forgot_password"
  map.reset_password 'reset_password/:reset_token', :controller => "accounts", :action => 'reset_password'
  map.activate_user 'activate_user/:activation_token', :controller => "accounts", :action => 'activate_user'
  map.cart '/cart', :controller => "carts", :action => "show"
  map.checkout '/checkout' , :controller => "orders", :action => "checkout"
  
  map.resources :accounts, :member => {:settings => :get, :change_password => :put} , :collection => {:send_reset_link => :any}

  map.resource :session
  
  map.resources :carts , :collection => {:empty_cart => :any ,:change_cart_values => :post},:member => {:remove_product => :any}

  map.resources :categories
  
  map.resources :users ,:member => {:create_new_customer_profile_on_authorize => :put ,:create_new_payment_profile => :put,
                                    :create_new_customer_profile =>:get , :new_shipping_profile => :any,:new_billing_profile => :any ,
                                    :edit_billing_profile => :get ,:update_billing_profile => :put ,:edit_shipping_profile => :get ,
                                    :update_shipping_profile => :put}
                                    
  map.resources :products ,:member => {:add_to_cart => :post ,:upload_photo => :post}
  
  map.resources :orders , :member => {:order_payment =>:any}
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
