WeddingAlbum::Application.routes.draw do

  resources :paintings


  resources :galleries

  devise_for :users, :controller => {:registrations => 'registrations', :sessions => 'users/sessions'}

  resource :users do
    resources :profile
  end

  resources :authentications, :only =>[:create, :destroy]

  authenticated :user do
    root :to => 'paintings#index'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
  #root :to => "static_pages#home"
  root :to => 'paintings#index'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/account' => 'static_pages#account'
  match '/social_media' => 'static_pages#social_media'

  match '/change_url' => 'static_pages#change_url'
  match '/change_picture' => 'static_pages#change_picture'
  match '/change_picture/:id' => 'static_pages#change_picture'
  match 'ajax.:action' => 'ajax'
  match '/change_avatar/:provider' => 'avatars#change'
  match '/set_avatar/:provider_name' => 'avatars#set_avatar'
  match '/profile/:id' => 'profile#show'

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  #match '/auth/facebook/logout' => 'application#facebook_logout', :as => :facebook_logout
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
