class SessionsController < ApplicationController
  def new
  	
  end
  def create
  user = login(params[:email], params[:password], params[:remember_me])
  
  if user
      # block == true -> no bloqueado
      if user.block == true
        redirect_back_or_to root_path, :notice => "Bienvenido a Estudio Vienna"
      else
        logout
        #flash.now.alert = "su cuenta a sido bloqueada"
        if user.active == true
          redirect_to root_path, :notice => "su cuenta a sido bloqueada, porfavor contactarse con el administrador"
        else
          redirect_to root_path, :notice => "su cuenta no ha sido activada, porfavor revise su correo electronico para activar su cuenta"
        end 
      end
  else
      flash.now.alert = "El correo electronico o la password es invalido"
      render :new
  end
  
  end

def destroy
  logout
  redirect_to root_path, :notice => "Se ha cerrado sesion"
end
end
