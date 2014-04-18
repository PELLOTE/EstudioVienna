class MusicStylesController < ApplicationController
  # GET /music_styles
  # GET /music_styles.json
  def index
    @music_styles = MusicStyle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_styles }
    end
  end

  # GET /music_styles/1
  # GET /music_styles/1.json
  def show
    @music_style = MusicStyle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_style }
    end
  end

  # GET /music_styles/new
  # GET /music_styles/new.json
  def new
    @music_style = MusicStyle.new
    @boton = " Agregar estilo musical"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music_style }
    end
  end

  # GET /music_styles/1/edit
  def edit
    @music_style = MusicStyle.find(params[:id])
    @boton = " Actualizar estilo musical"
  end

  # POST /music_styles
  # POST /music_styles.json
  def create
    @music_style = MusicStyle.new(params[:music_style])

    respond_to do |format|
      if @music_style.save
        format.html { redirect_to @music_style, notice: "El estilo musical #{@music_style.name} ha sido creado exitosamente." }
        format.json { render json: @music_style, status: :created, location: @music_style }
      else
        format.html { render action: "new" }
        format.json { render json: @music_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /music_styles/1
  # PUT /music_styles/1.json
  def update
    @music_style = MusicStyle.find(params[:id])

    respond_to do |format|
      if @music_style.update_attributes(params[:music_style])
        format.html { redirect_to @music_style, notice: "El estilo musical #{@music_style.name} ha sido actualizado exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @music_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_styles/1
  # DELETE /music_styles/1.json
  def destroy
    @music_style = MusicStyle.find(params[:id])
    @music_style.destroy

    respond_to do |format|
      format.html { redirect_to music_styles_url }
      format.json { head :no_content }
    end
  end
end
