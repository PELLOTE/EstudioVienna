class Ability
  include CanCan::Ability

    def initialize(user)
      user ||= User.new
      if user.user_type_id == 1
        
        #can :crud, Article
        #can :listarSolicitudes, Booking
        can :manage, :all
      elsif user.user_type_id == 2
        alias_action :index, :create, :read, :update, :destroy, :to => :crud
        
        can :crud , Booking
        can :listarSolicitudes, Booking
        can :listarReservas, Booking
        can :cancelarReservas, Booking
        can :AsignarTool, Booking

        can :crud , Member
        can :crud , Group
        can :crud , Assistant                    
        
        can :crud           , User
        can :edit_contrasena, User
        can :viewactivar    , User
        can :activarUsuario , User
        can :enviarmail     , User
        can :enviar         , User

      end
      #can :read, :all
      can :viewactivar    , User #activar cuenta
      can :activarUsuario , User #activar cuenta
      can :create         , User

      alias_action :index, :read, :update, :destroy, :desbloquearUsuario, :bloquearUsuario, :asignartipo, :to => :user_acceso
      can :user_acceso   , User

      can :index , Group
      can :read  , Group

    end
end
