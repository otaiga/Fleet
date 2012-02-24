Fleet::Application.routes.draw do

  get "api/index"

  get "page/about"
  get "page/support"
  get "page/terms"

  get "main/Index"
  get "main/new_device_create"
  get "main/new_group_create"
  match "main/create" => "main#create"
  match "main/create_group" => "main#create_group"

  get "group/edit"
  match "group/destroy" => "group#destroy"

  get "policy/index"
  get "policy/edit"
  match "policy/create" => "policy#create"
  match "policy/destroy" => "policy#destroy"
  match "policy/append_to_group" => "policy#append_to_group"
  match "policy/updatesettings" => "policy#updatesettings"
  match "policy/updatelock" => "policy#updatelock"

  match "main/device_destroy" => "main#device_destroy"


  get "phone_list/show"
  match "phone_list/create" => "phone_list#create"
  match "phone_list/edit" => "phone_list#edit"
  match "phone_list/destroy_list_item" => "phone_list#destroy_list_item"
  match "phone_list/destroy" => "phone_list#destroy"
  match "phone_list/create_list_item" => "phone_list#create_list_item"
  resources :api
  devise_for :accounts

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
   root :to => 'main#Index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
