HeroServer::Application.routes.draw do

  # Application
  get '/ping' => 'application#ping', as: :ping
  get '/google(/:q)' => 'tools#google', as: :google   # used to be bins#google now it is bins#new_google
  get '/scratch' => 'tools#scratch', as: :scratch
  post '/scratch/save' => 'tools#scratch_save', as: :scratch_save


  scope '/notes' do
    get '/' => 'notes#index', as: :notes
    get '/tags' => 'notes#tags', as: :notes_tags
    get '/no_tag' => 'notes#no_tag', as: :notes_no_tag
    get '/tag/:tag' => 'notes#tag', as: :notes_tag
    get '/show/:id' => 'notes#show', as: :notes_show
    get '/edit/:id' => 'notes#edit', as: :notes_edit
  end

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
