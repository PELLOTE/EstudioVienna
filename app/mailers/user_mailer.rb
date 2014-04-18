class UserMailer < ActionMailer::Base
  default :from => "viennestudio@gmail.com"
 
  def welcome_email(user)
    @user = user 
    #@url = viewactivar_url(user)   
    mail(:to => user.email, :subject => "Bienvenido a Estudio Vienna")
  end

  def reserva(booking, user)
  	@user = user
  	@booking = booking
  	mail(:to => user.email, :subject => "Reserva sala ensayo Estudio Vienna")
  end

  def mails(subject,  body, user )
    @user = user
    @body = body

    mail(:to => @user.email, 
    :subject => subject)
  end

  def mailContacto(subject,  body, email, emailcontacto, nombre )
    @body = body 
    @contacto = emailcontacto
    @nombre = nombre

    mail(:to => email, :subject => subject)
  end
  
  def recuerdaEmail(user, booking)
    @user = user
    @booking = booking
    mail(:to => @user.email, :subject => "Reserva pendiente")
  end
  
  def confirmarsolicitud(booking, user)
    @user = user
    @booking = booking 
    mail(:to => @user.email, :subject => "Reserva confirmada")     
  end

  def noConfirmado(booking, user)
    @user = user
    @booking = booking
    mail(:to => @user.email, :subject => "Reserva perdida")
   end

  def RecuperarContrasena(user)
    @user = user
    mail(:to => @user.email, :subject => "Solicitud de recuperacion de password")
  end

end
