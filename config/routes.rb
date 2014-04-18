EstudioVienna::Application.routes.draw do
  
  resources :characters
  resources :articles
  resources :user_types


  get "sessions/new"
  get "users/new"
  get "users/delete"
  get "welcome/index"
  get "welcome/contact"
  get "welcome/aboutus"

  resources :booking_tools
  resources :tools
  resources :booking_times
  resources :horas
  resources :style_groups
  resources :music_styles
  resources :users
  resources :sessions

  resources :rooms do
    resources :equipment
  end

  resources :groups do
    resources :members
  end

  resources :bookings do
    resources :assistants
  end

  
  ############ Usuario ################
  get "logout"    => "sessions#destroy",  :as => "logout"
  get "login"     => "sessions#new",      :as => "login"
  get "signup"    => "users#new",         :as => "signup"
  

  
  match 'asignartipo/:id' => 'users#asignartipo', :as => :asignartipo
  match 'editarContrasena/:id/edit_contrasena' => 'users#edit_contrasena', as: :edit_contrasena
  match 'update_contrasena/:id' => 'users#update_contrasena', as: :update_contrasena
  ##########grupos ####################
  match 'misgrupos/:id' => 'groups#misgrupos', :as => :misgrupos
  ############ Solicitudes ################
  match 'listarSolicitudes'       => 'bookings#listarSolicitudes',    as: :listarSolicitudes
  match 'cancelarReservas/:id'    => 'bookings#cancelarReservas',     as: :cancelarReservas
  match 'confirmarSolicitud/:id'  => 'bookings#confirmarSolicitud',   as: :confirmarSolicitud

  ############ Reservas ################
  match 'listarReservas'          => 'bookings#listarReservas',       as: :listarReservas
  match 'controlarAsistencia'     => 'bookings#controlarAsistencia',  as: :controlarAsistencia
  match 'AsistenciaPresente/:id'  => 'bookings#AsistenciaPresente',   as: :AsistenciaPresente
  match 'AsistenciaAusente/:id'   => 'bookings#AsistenciaAusente',    as: :AsistenciaAusente
  
  match 'AsignarTool/:id'         => 'bookings#AsignarTool',          as: :AsignarTool
  match 'FinalizarReserva/:id'    => 'bookings#FinalizarReserva',     as: :FinalizarReserva
  
  ############ Usuario ################
  match 'bloquearUsuario/:id'         => 'users#bloquearUsuario',          as: :bloquearUsuario
  match 'desbloquearUsuario/:id'      => 'users#desbloquearUsuario',       as: :desbloquearUsuario
  match 'activarUsuario/:id'          => 'users#activarUsuario',           as: :activarUsuario
  match 'viewactivar/:id'             => 'users#viewactivar',              as: :viewactivar
  match 'recuperar_contrasena/:id'    => 'users#recuperar_contrasena',     as: :recuperar_contrasena
  match 'solicitudRecuperacionContrasena' => 'users#solicitudRecuperacionContrasena',     as: :solicitudRecuperacionContrasena
  

  match 'enviarmail'      => 'users#enviarmail',       as: :enviarmail



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
   root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
