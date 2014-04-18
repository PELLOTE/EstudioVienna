class UsersController < ApplicationController
#load_and_authorize_resource
def new
  @user = User.new
end

def create
  @user = User.new(params[:user])
  @user.surname = @user.lastname.split(' ').last
  @user.lastname = @user.lastname.split(' ').first  
  @user.user_type_id = 2
  @user.block = false
  @user.active = false
  
  if @user.save
    UserMailer.welcome_email(@user).deliver
    redirect_to root_path, :notice => "Se ha enviado un correo electronico a #{@user.email} para confirmar su registro"
  else
    render :new
  end
end

def show
   @user = User.find(params[:id])
end

def index
	#@user = User.find(:all, :order => ['user_type_id' ,'name'])
  @user = User.find(:all, :joins => :user_type, :order =>["user_types.name","users.name"])
  
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user}
    end
end

def destroy
  @user = User.find(params[:id])
  @user.destroy

  respond_to do |format|
    format.html { redirect_to users_path }
    format.json { head :no_content }
  end
end

def asignartipo
	@user = User.find(params[:id])
	@tipoUsuario = UserType.all	
  @opcion = 1
end

def edit
    @user = User.find(params[:id])
  if current_user.user_type_id == 1 or current_user.id == @user.id 
    
  else
    redirect_back_or_to root_path, :notice => "No tiene permiso para actualizar este usuario"
  end

end

def update   
   @user = User.find(params[:id])   
   @cont = params[:cont]
   
    respond_to do |format|
      if @user.update_attributes(params[:user])
        if @cont != 1
          format.html { redirect_to users_path, notice: "El usuario #{@user.name} #{@user.lastname} ha sido actualizado exitosamente." }
          format.json { head :no_content }
        else
          format.html { redirect_to root_path, notice: "El usuario #{@user.name} #{@user.lastname} ha sido actualizado exitosamente." }
          format.json { head :no_content }
        end

      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end

def edit_contrasena
    @user = User.find(params[:id])
    @tipoUsuario = UserType.all 
    @op = "edit"      
end

def recuperar_contrasena
  @user = User.find(params[:id])
  @tipoUsuario = UserType.all 
  @op = "recuperar"      
end

def guardar_recuperar_contrasena
  @user = User.find(params[:id])
  @user.password = params[:password] 
  @user.password_confirmation = params[:password_confirmation] 
  
  if @user.password.blank? or @user.password_confirmation.blank?
    redirect_to recuperar_contrasena_path(@user.id), alert: "Debes ingresar y confirmar la nueva password."
  else
    if @user.password == @user.password_confirmation
      if @user.save
        redirect_to root_path, notice: "la password ha sido guardada exitosamente, Porfavor inicie sesion."    
      else     
      redirect_to recuperar_contrasena_path(@user.id), alert: "No se ha guardado la password, Porfavor intentelo de nuevo."
      end
    else    
      redirect_to recuperar_contrasena_path(@user.id), alert: "Las password deben ser IGUALES!."
    end
  end
end


def update_contrasena
  @user = User.find(params[:id])     
  if request.post? 
    if User.authenticate(@user.email, params[:old_password]) == @user
      @user.password = params[:nuevo_password] 
      @user.password_confirmation = params[:password_confirmation] 
      if @user.save 
         redirect_to root_path, message: "cambiaste tu password"
      else 
         
        redirect_to edit_contrasena_path
      end 
    else 
        flash.now[:alert] = 'Passord invalido' 
        redirect_to edit_contrasena_path
    end 
  end        
end

def bloquearUsuario
  @user = User.find(params[:id])
  @user.block = false
  
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: "El usuario #{@user.name} #{@user.lastname} ha sido Bloqueado exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

end

def desbloquearUsuario
  @user = User.find(params[:id])
  @user.block = true
  
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: "El usuario #{@user.name} #{@user.lastname} ha sido debloqueado exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end  
end

def viewactivar
  @user = User.find(params[:id])
  if @user.active == true
    redirect_to root_path
  end
end

def activarUsuario
  @user = User.find(params[:id])
  @user.block = true
  @user.active = true
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {redirect_to login_path(:email => @user.email), notice: "la cuenta ha sido activada exitosamente, porfavor inicie sesion." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end  
end

def enviarmail
  @user = User.all
  
end

def enviar
  params[:id] ||= [] 
  @usuario = params[:user_id]
  @subject = params[:subject]
  @body = params[:body]
   @usuario.each do |usu|
    @user = User.find(usu)
        UserMailer.mails(@subject, @body, @user).deliver
    end
    redirect_to root_path
end

def solicitudRecuperacionContrasena
  
end

def enviarSolicitudRecuperacionContrasena
  @email1 = params[:email]
  @user = User.where(:email => @email1)
  if @user.blank?
    redirect_back_or_to solicitudRecuperacionContrasena_path, :alert => "Debe ingresar un correo electronico valido"
  else
    if @user
      @user.each do |u|

      UserMailer.RecuperarContrasena(u).deliver
     end  
      redirect_to root_path, notice: "El mail se ha mandado exitosamente."
    else
       redirect_back_or_to solicitudRecuperacionContrasena_path, :alert => "Debe ingresar un correo electronico valido"

    end
  end
end



end