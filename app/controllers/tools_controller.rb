class ToolsController < ApplicationController
  load_and_authorize_resource
  def index
    @tools = Tool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tools }
    end
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
    @tool = Tool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tool }
    end
  end

  # GET /tools/new
  # GET /tools/new.json
  def new
    @tool = Tool.new
    @boton = " Crear Herramienta"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tool }
    end
  end

  # GET /tools/1/edit
  def edit
    @tool = Tool.find(params[:id])
    @boton = " Actualizar Herramienta"
  end

  # POST /tools
  # POST /tools.json
  def create
    @tool = Tool.new(params[:tool])

    respond_to do |format|
      if @tool.save
        format.html { redirect_to @tool, notice: "#{@tool.quantity} #{@tool.name} #{@tool.trademark} ha(n) sido agregada(s) exitosamente" }
        format.json { render json: @tool, status: :created, location: @tool }
      else
        format.html { render action: "new" }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tools/1
  # PUT /tools/1.json
  def update
    @tool = Tool.find(params[:id])

    respond_to do |format|
      if @tool.update_attributes(params[:tool])
        format.html { redirect_to @tool, notice: "#{@tool.name} #{@tool.trademark} ha sido actualizada exitosamente." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    respond_to do |format|
      format.html { redirect_to tools_url }
      format.json { head :no_content }
    end
  end
end
