class AssistantsController < ApplicationController
  # GET /assistants
  # GET /assistants.json
  def index
    @assistants = Assistant.all   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assistants }
    end
  end

  # GET /assistants/1
  # GET /assistants/1.json
  def show
    @assistant = Assistant.find(params[:id])
    @booking  = Booking.find(params[:booking_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assistant }
    end
  end

  # GET /assistants/new
  # GET /assistants/new.json
  def new
    @booking  = Booking.find(params[:booking_id])
    if current_user.user_type_id == 1 or current_user.id == @booking.user_id 
      @back = "new"
      @boton = " Agregar asistente"
      @assistant = Assistant.new
      @day = params[:day]
      @month = params[:month]
      @year = params[:year]
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @assistant }
      end
    else
      redirect_back_or_to root_path, :alert => "No tiene permiso para agregar un asistente a esta reserva"
    end
  end

  # GET /assistants/1/edit
  def edit
    @back = "edit"
    @boton = " Actualizar asistente"
    @assistant = Assistant.find(params[:id])
    @booking  = Booking.find(params[:booking_id])
  end

  # POST /assistants
  # POST /assistants.json
  def create
    @booking  = Booking.find(params[:booking_id])
    @assistant = @booking.assistants.new(params[:assistant])
    respond_to do |format|
      if @assistant.save
        format.html { redirect_to @booking, notice: "Se ha agregado exitosamente a #{@assistant.name} #{@assistant.lastname} como asistente a la reserva." }
        format.json { render json: @assistant, status: :created, location: @assistant }
      else
        format.html { render action: "new" }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assistants/1
  # PUT /assistants/1.json
  def update
    @assistant = Assistant.find(params[:id])
    @booking  = Booking.find(params[:booking_id])
    respond_to do |format|
      if @assistant.update_attributes(params[:assistant])
        format.html { redirect_to @booking, notice: "Se ha actualizado al asistente #{@assistant.name} #{@assistant.lastname} exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistants/1
  # DELETE /assistants/1.json
  def destroy
    @booking  = Booking.find(params[:booking_id])
    @assistant = Assistant.find(params[:id])
    @assistant.destroy

    respond_to do |format|
      format.html { redirect_to @booking }
      format.json { head :no_content }
    end
  end
end
