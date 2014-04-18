class BookingsController < ApplicationController
  load_and_authorize_resource

  def index  
    @bookings = Booking.includes(:horas).order('horas.name').find(:all, :conditions => {:user_id => current_user.id, :estate => ["Solicitado","Confirmado"]})
    @bookings_by_date = @bookings.group_by(&:fecha)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    #restringiendo el acceso
    if current_user.user_type_id == 1 or current_user.id == @booking.user_id 
      #@booking = Booking.find(params[:id])
      #@booking = Booking.includes(:horas).find(params[:id])
      @booking = Booking.find(params[:id], :include => [ :horas ])

      @assistant = Assistant.where(:booking_id => params[:id] )
      @equipos = Booking.includes(:tools).find(params[:id])  
      @cantidad_horas = 0
      @precio_instrumentos = 0

      #########################

      if @equipos.tools.count != 0 
        @equipos.tools.each do |tool| 
         tool.name
         tool.price_unitary
         @precio_instrumentos = @precio_instrumentos + tool.price_unitary.to_i
        end
      end
      
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @booking }
      end
    else
      redirect_back_or_to root_path, :alert => "No tiene permiso para acceder a esta reserva"
    end
  end

  # GET /bookings/new
  # GET /bookings/new.json
  def new    
    #################
    @opcion = "new"
    @boton = " Solicitar reserva"
    #################
    
    @booking = Booking.new
    @rooms = Room.all
    @day = params[:day]
    @month = params[:month]
    @year = params[:year]
    @fecha = "#{@year}-#{@month}-#{@day}" # formato Chile
    @horacreadas = Hora.find(:all, :order => 'name')
    @Reservas_dia_1 = Booking.includes(:horas).where(:fecha => @fecha, :room_id =>1).order('horas.name')
    @Reservas_dia_2 = Booking.includes(:horas).where(:fecha => @fecha, :room_id =>2).order('horas.name')

    #@Reservas_dia =Booking.includes(:horas).find(:all, :conditions =>{:fecha => @fecha})
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    
    #################
    @boton = " Actualizar solicitud"
    @opcion = "update"
    #################
    
    @booking = Booking.find(params[:id])
    @rooms = Room.all
    @day = @booking.fecha.day
    @month = @booking.fecha.month
    @year = @booking.fecha.year
    @fecha = "#{@day}/#{@month}/#{@year}"
    @fecha_pg = "#{@year}-#{@month}-#{@day}"
    @horacreadas = Hora.find(:all, :order => 'name')
    @Reservas_dia_1 =Booking.includes(:horas).where(:fecha => @fecha_pg, :room_id =>1).order('horas.name')
    @Reservas_dia_2 =Booking.includes(:horas).where(:fecha => @fecha_pg, :room_id =>2).order('horas.name')
    
  end

  # POST /bookings
  # POST /bookings.json
def create
    @booking = Booking.new(params[:booking])
    @booking.estate = "Solicitado"
    @booking.amount = 0
    @booking.fecha = params[:fecha]
    @booking.user_id = params[:userid]
    @user = User.find(params[:userid])
    #reservas_dia contiene todas las reservas del la fecha seleccionada y la sala seleccionada
    @Reservas_dia =Booking.where(:fecha => params[:fecha], :room_id => @booking.room_id, :estate => ["Solicitado","Confirmado"])


  if @booking.horas.blank?
    @cont = 2 #si la hora esta en blanco
  else
    @Reservas_dia.each do |r| #iterramos las reservas_dia 
      @ho = Booking.includes(:horas).find(r.id) #buscar las horas de la reserva_dias
      @ho.horas.each do |h|  #iteramos las horas de reservas_dia 
        @booking.horas.each do |hr| #buascamos las horas selecionada em el new que llega como parametro
          if h.name == hr.name  #comparar si la hora h (horas de las reservas_dias ) en igual a hr (hora selecionada en el new)
              @cont = 1
          end  
        end
      end
    end
  end 

  if @cont.blank? # se pregunta si cont contiene  algo si es null o esta en blanco entra y genera la reserva
    respond_to do |format|
      
        if @booking.save
            UserMailer.reserva(@booking, @user).deliver
            format.html { redirect_to booking_path(@booking), notice: "La solicitud una reserva para el dia #{@booking.fecha} se ha generado exitosamente." }
            format.json { render json: @booking, status: :created, location: @booking }
        else
            format.html { render action: "new" }
            format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      
      end 
    
  else
      if @cont == 1
        redirect_back_or_to new_booking_path(:day => @booking.fecha.day, :month => @booking.fecha.month, :year => @booking.fecha.year), :alert => "La hora para reserva que usted eligio no esta disponible, porfavor eliga otra hora teniendo en cuenta el horario con las horas disponibles"
       else 
        redirect_back_or_to new_booking_path(:day => @booking.fecha.day, :month => @booking.fecha.month, :year => @booking.fecha.year), :alert => "Debe seleccionar una hora para poder generar la solicitud de reserva."
        @cont = 2
      end
  end
end 
# PUT /bookings/1
  # PUT /bookings/1.json
def update
  #reserva que el cliente ya posee registrada
  @booking = Booking.includes(:horas).find(params[:id])
  #reservas diarias dependiendo de la fecha
  @Reservas_dia =Booking.where(:fecha => @booking.fecha, :room_id => @booking.room_id, :estate => ["Solicitado","Confirmado"])
  #reserva que viene con datos actualizados
  @Reserva_form = Booking.new(params[:booking])

 
  @tool_op = params[:tool_op]
  
  #####################
  # solo si viene de asignar tool
if @tool_op.blank?
   respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to @booking, notice: "asdasd" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
else
  #####################

  if @Reserva_form.horas.blank?
   redirect_back_or_to edit_booking_path(@booking), :alert => "Debe seleccionar una hora para poder generar la solicitud de reserva."
  else
    @horas_iguales = []
    #revisar si existe la horas solicitadas
    @Reserva_form.horas.each do |hf| #hf -> hora formulario
      @booking.horas.each do |ha| # ha -> hora actual yia registrada
        
        if hf.name != ha.name # si hora formulario es distinto de hora actual 
          @Reservas_dia.each do |r|# r -> reservas diarias
            @reserva = Booking.includes(:horas).find(r.id)
            @reserva.horas.each do |h|
              if hf.name != h.name # si hora de formulario es igual a la hora de una reserva
                @horas_iguales.each do |hi| 
                  if hi != hf.name # si la hora que yia esta registrada es igual que la hora de la reserva
                    #@cont = 1
                  end              
                end 
              else
                @booking.horas.each do |b| # ver la hora que es nueva si existe en el formulario
                  if hf.name == b.name
                    @aux = 1
                  end
                end
                if @aux.blank?
                  @cont = 1
                end
              end
            end
          end
        else          
          @horas_iguales << hf.name
        end        
      end
    end
      

      if @cont.blank? #5
        respond_to do |format|
          if @booking.update_attributes(params[:booking])
            format.html { redirect_to @booking, notice: "La reserva para el dia #{@booking.fecha} ha sido actualizada exitosamente." }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @booking.errors, status: :unprocessable_entity }
          end
        end
      else
        if @cont == 1
          redirect_back_or_to edit_booking_path(@booking), :alert => "La hora para reserva que usted eligio no esta disponible, porfavor eliga otra hora teniendo en cuenta el horario con las horas disponibles"
        end

      end#5
  end
end
end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  
  def destroy
    @booking = Booking.find(params[:id])
    @cont = params[:cont]
    @booking.destroy

    respond_to do |format|
      if @cont == 1
        format.html { redirect_to listarSolicitudes_path }
        format.json { head :no_content }
      elsif @cont == 2
        format.html { redirect_to listarReservas_path }
        format.json { head :no_content }
      else        
        format.html { redirect_to root_path }
        format.json { head :no_content }
      end
    end
  end

############################################# Solicitudes  ###########################################################

  #definicion que lista todas la solicitudes de reserva realizadas
  def listarSolicitudes
    @booki = Booking.where(:estate => "Solicitado" )

    @booki.each do |b|
      @user = User.find(b.user_id)
      @fecha_creacion = b.created_at 
      @fecha_reserva = b.fecha
      if @fecha_creacion +2.day < Date.today or @fecha_reserva < Date.today
          b.estate = "NoConfirmado"
          b.save
          UserMailer.noConfirmado(b, @user).deliver
      end
    end
    if current_user
      if current_user.user_type_id == 1
        @bookings     = Booking.includes(:horas).where(:estate => "Solicitado" ).order(:fecha, :room_id, 'horas.name')
        @noconfirmado = Booking.includes(:horas).where(:estate => "NoConfirmado").order(:fecha, :room_id, 'horas.name')
        @cancelada    = Booking.includes(:horas).where(:estate => "Cancelado").order(:fecha, :room_id, 'horas.name')
      else
        @bookings     = Booking.includes(:horas).where(:estate => "Solicitado", :user_id => current_user.id  ).order(:fecha, :room_id, 'horas.name')
        @noconfirmado = Booking.includes(:horas).where(:estate => "NoConfirmado", :user_id => current_user.id).order(:fecha, :room_id, 'horas.name')
        @cancelada    = Booking.includes(:horas).where(:estate => "Cancelado", :user_id => current_user.id).order(:fecha, :room_id, 'horas.name')
      end # fin current_user.user_type_id 
    end # fin current_user
  end

  def cancelarReservas
    @booking = Booking.find(params[:id])
    if @booking.estate == "Solicitado"
      @booking.estate = "Cancelado"
    elsif @booking.estate == "Confirmado"
      @booking.estate = "Cancelado_Confirmado" 
    end

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        if @booking.estate == "Cancelado"
          format.html { redirect_to listarSolicitudes_path, notice: "La solicitud de reserva para el dia #{@booking.fecha} ha sido cancelada exitosamente." }
        elsif @booking.estate == "Cancelado_Confirmado"
          format.html { redirect_to listarReservas_path, notice: "La solicitud de reserva para el dia #{@booking.fecha} ha sido cancelada exitosamente." }
        end
        
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmarSolicitud
    @booking = Booking.find(params[:id])
    @rooms = Room.all
   
  end

  def guardarConfirmarSolicitud
    @booking = Booking.find(params[:id])
    @user = User.find(@booking.user_id)
    @booking.amount = params[:amount]
    @booking.estate = "Confirmado"

    respond_to do |format|
      if @booking.update_attributes(params[:booking]) 
        UserMailer.confirmarsolicitud(@booking, @user).deliver
        format.html { redirect_to listarSolicitudes_path, notice: "La solicitud de reserva para el dia #{@booking.fecha} ha sido confirmada exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  ############################################# Reservas  ###########################################################

  def listarReservas
    @booki = Booking.where(:estate => "Confirmado" )

    @booki.each do |b|
      @date = b.fecha 
      if b.fecha < Date.today
          b.estate = "Confirmado_NoFinalizado"
          b.save
      end
    end
    if current_user
      if current_user.user_type_id == 1
        @bookings   = Booking.includes(:horas).where(:estate => "Confirmado" ).order(:fecha, :room_id, 'horas.name')
        @finalizada = Booking.includes(:horas).where(:estate => "Finalizado" ).order(:fecha, :room_id, 'horas.name')
        @cancelada  = Booking.includes(:horas).where(:estate => "Cancelado_Confirmado" ).order(:fecha, :room_id, 'horas.name')
        @confirmadoNoFinalizado  = Booking.includes(:horas).where(:estate => "Confirmado_NoFinalizado" ).order(:fecha, :room_id, 'horas.name')
        @noAsistido = Booking.includes(:horas).where(:estate => "NoAsistido" ).order(:fecha, :room_id, 'horas.name')
      else
        @bookings   = Booking.includes(:horas).where(:estate => "Confirmado", :user_id => current_user.id  ).order(:fecha, :room_id, 'horas.name')
        @finalizada = Booking.includes(:horas).where(:estate => "Finalizado", :user_id => current_user.id  ).order(:fecha, :room_id, 'horas.name')
        @cancelada  = Booking.includes(:horas).where(:estate => "Cancelado_Confirmado",  :user_id => current_user.id  ).order(:fecha, :room_id, 'horas.name')
        @confirmadoNoFinalizado  = Booking.includes(:horas).where(:estate => "Confirmado_NoFinalizado",  :user_id => current_user.id  ).order(:fecha, :room_id, 'horas.name')
        @noAsistido = Booking.includes(:horas).where(:estate => "NoAsistido" ).order(:fecha, :room_id, 'horas.name')
      end # fin current_user.user_type_id 
    end # fin current_user
  end



  def controlarAsistencia
    @sala = Room.all
    @fecha_actual = Date.today
    @reservas_sala1 =  Booking.where( :room_id => 1, :fecha => @fecha_actual ).order(:fecha)
    @reservas_sala2 =  Booking.where( :room_id => 2, :fecha => @fecha_actual ).order(:fecha)    
  end

  def AsistenciaPresente
    @booking = Booking.find(params[:id])
    @booking.estate = "Asistido"

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to controlarAsistencia_path, notice: "La reserva para el dia #{@booking.fecha} se marcado como presente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end    
  end


  def AsistenciaAusente    
    @booking = Booking.find(params[:id])
    @booking.estate = "NoAsistido"

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to controlarAsistencia_path, notice: "La reserva para el dia #{@booking.fecha} se marcado como ausente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end
  ################################# Asignar equipo y/o Accesorio a reseva  #####################################

 def AsignarTool
    @booking = Booking.find(params[:id])
    @tool_op = 1
 end


 ################################# Finalizar reserva  #####################################

 def FinalizarReserva
  @booking = Booking.find(params[:id], :include => [ :horas ])
  @equipos = Booking.includes(:tools).find(params[:id])  
  @sala    = Room.find(@booking.room_id)
  @assistant = Assistant.where(:booking_id => params[:id] )
  @cantidad_horas = 0
  @precio_instrumentos = 0

    #########################

    if @equipos.tools.count != 0 
      @equipos.tools.each do |tool| 
       @precio_instrumentos = @precio_instrumentos + tool.price_unitary.to_i
      end
    end


    
 end 
 def guardarFinalizarReserva
    @booking = Booking.find(params[:id])
    @booking.estate = "Finalizado"

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to controlarAsistencia_path, notice: "La reserva para el dia #{@booking.fecha} ha sido finalizada exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
 end 

end