class WelcomeController < ApplicationController
  
 def index
  	@articles = Article.all
  end

  def contact

  end

  def aboutus
    @characters = Character.all
    @json = Character.all.to_gmaps4rails
  end

  def enviarContacto

  if current_user
    @nombre = "#{current_user.name} #{current_user.lastname} #{current_user.surname}"
    @email = current_user.email
  else
    @nombre = params[:nombre]
    @email = params[:email]
  end
  	@subject = params[:subject]
  	@body = params[:body]
    if @nombre.blank? or @email.blank? or  @subject.blank? or @body.blank?
      redirect_to welcome_contact_path, alert: "Debe escribir en todos los campos para poder enviar el mensaje, porfavor intentelo de nuevo."
    else
      if UserMailer.mailContacto(@subject, @body, "estudiovienna@gmail.com", @email, @nombre).deliver  
      	redirect_to root_path, notice: "El mensaje se ha mandado exitosamente, espere mientras el administrador de contacta con usted."
      end
    end
  end
end
