class MembersController < ApplicationController
  load_and_authorize_resource
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])
    @group  = Group.find(params[:group_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
    @group  = Group.find(params[:group_id])
    @boton = " Agregar integrante"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @group  = Group.find(params[:group_id])
    @member = Member.find(params[:id])
    @boton = " Actualizar integrante"
  end

  # POST /members
  # POST /members.json
  def create
   @group = Group.find(params[:group_id])
   @member = @group.members.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @group, notice: "Se ha agregado un integrante a #{@group.name}." }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])
     @group  = Group.find(params[:group_id])
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @group, notice: "Se ha actualizado un integrante de #{@group.name}." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end