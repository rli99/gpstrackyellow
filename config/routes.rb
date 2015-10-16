Rails.application.routes.draw do
    
  # get '/users/edit' => 'user#edit'
  devise_for :users
  root 'welcome#index'
  get 'welcome/index'
  get 'view/map'
  get 'view/gmap'
  get '/view/tripdata'
  post '/view/tripdata' => 'trip#verify'
  post 'view/change_event_transportation/:event_id' => 'view#change_event_transportation', as: :view_change_event_transportation
  post 'view/delete_transfer_zone/:transfer_zone_id' => 'view#delete_transfer_zone', as: :view_delete_transfer_zone
  post 'view/change_to_transfer_zone/:intpoint_id' => 'view#change_to_transfer_zone', as: :view_change_to_transfer_zone
  post 'view/drag_transfer_zone_to_intpoint/:transfer_zone_id' => 'view#drag_transfer_zone_to_intpoint', as: :view_drag_transfer_zone_to_intpoint
  
  post 'datatransformation/transfrom_to_tripdata' => 'datatransformation#transform_to_tripdata', as: :data_transform
  match '/gps-data' => 'gps_incoming_service#receive_data', via: :post
  
  get '/profile' => 'view#profile'
  post '/profile' => 'view#update'
  post '/users/edit' => 'user#update'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
