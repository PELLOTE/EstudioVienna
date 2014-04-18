class HorasController < ApplicationController
  load_and_authorize_resource
  
  def index
    @horas = Hora.find(:all , :order => :name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @horas }
    end
  end

  # GET /horas/1
  # GET /horas/1.json
  def show
    @hora = Hora.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hora }
    end
  end

  # GET /horas/new
  # GET /horas/new.json
  def new
    @hora = Hora.new
    @boton = " Crear Hora"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hora }
    end
  end

  # GET /horas/1/edit
  def edit
    @hora = Hora.find(params[:id])
    @boton = " Actualizar Hora"
  end

  # POST /horas
  # POST /horas.json
  def create
    @hora = Hora.new(params[:hora])

    respond_to do |format|
      if @hora.save
        format.html { redirect_to @hora, notice: "La hora #{@hora.name} ha sido agregada exitosamente." }
        format.json { render json: @hora, status: :created, location: @hora }
      else
        format.html { render action: "new" }
        format.json { render json: @hora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /horas/1
  # PUT /horas/1.json
  def update
    @hora = Hora.find(params[:id])

    respond_to do |format|
      if @hora.update_attributes(params[:hora])
        format.html { redirect_to @hora, notice: "La hora #{@hora.name} ha sido actualizada exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horas/1
  # DELETE /horas/1.json
  def destroy
    @hora = Hora.find(params[:id])
    @hora.destroy

    respond_to do |format|
      format.html { redirect_to horas_url }
      format.json { head :no_content }
    end
  end
end
