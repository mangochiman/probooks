ActionController::Routing::Routes.draw do |map|
  map.login  '/login',  :controller => 'users', :action => 'login'
  map.logout  '/logout',  :controller => 'users', :action => 'logout'
  map.new_user  '/new_user',  :controller => 'users', :action => 'new_user'
  map.view_users  '/view_users',  :controller => 'users', :action => 'view_users'
  map.void_users  '/void_users',  :controller => 'users', :action => 'void_users'
  map.authenticate  '/authenticate',  :controller => 'users', :action => 'authenticate'
  map.home  '/pages',  :controller => 'pages', :action => 'home'
  map.upload_books_menu  '/upload_books_menu',  :controller => 'admin', :action => 'upload_books_menu'
  map.view_books_menu  '/view_books_menu',  :controller => 'admin', :action => 'view_books_menu'
  map.remove_books_menu  '/remove_books_menu',  :controller => 'admin', :action => 'remove_books_menu'
  map.new_faculties_menu  '/new_faculties_menu',  :controller => 'admin', :action => 'new_faculties_menu'
  map.edit_faculties_menu  '/edit_faculties_menu',  :controller => 'admin', :action => 'edit_faculties_menu'
  map.view_faculties_menu  '/view_faculties_menu',  :controller => 'admin', :action => 'view_faculties_menu'
  map.remove_faculties_menu  '/remove_faculties_menu',  :controller => 'admin', :action => 'remove_faculties_menu'
  map.new_users_menu  '/new_users_menu',  :controller => 'admin', :action => 'new_users_menu'
  map.edit_users_menu  '/edit_users_menu',  :controller => 'admin', :action => 'edit_users_menu'
  map.view_users_menu  '/view_users_menu',  :controller => 'admin', :action => 'view_users_menu'
  map.remove_users_menu  '/remove_users_menu',  :controller => 'admin', :action => 'remove_users_menu'
  map.edit_faculty '/edit_faculty/:faculty_id', :controller => 'admin', :action => 'edit_faculty'
  map.browse_by_category '/browse_by_category/:category_id', :controller => 'admin', :action => 'browse_by_category'
  map.edit_user '/edit_user/:user_id', :controller => 'admin', :action => 'edit_user'
  map.view_by_faculty '/view_by_faculty/:faculty_id', :controller => 'admin', :action => 'view_by_faculty'
  map.dashboard  '/dashboard',  :controller => 'students', :action => 'dashboard'
  map.select_books_from_store  '/select_books_from_store',  :controller => 'students', :action => 'select_books_from_store'
  map.my_recent_books_menu  '/my_recent_books_menu',  :controller => 'students', :action => 'my_recent_books_menu'
  map.extras  '/extras',  :controller => 'students', :action => 'extras'
  map.my_account  '/my_account',  :controller => 'students', :action => 'my_account'
  map.view_by_faculty '/select_books_by_faculty/:faculty_id', :controller => 'students', :action => 'select_books_by_faculty'
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
  map.root :controller => "pages", :action => "home"
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
