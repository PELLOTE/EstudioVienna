class StyleGroupsController < ApplicationController
  # GET /style_groups
  # GET /style_groups.json
  def index
    @style_groups = StyleGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @style_groups }
    end
  end

  # GET /style_groups/1
  # GET /style_groups/1.json
  def show
    @style_group = StyleGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @style_group }
    end
  end

  # GET /style_groups/new
  # GET /style_groups/new.json
  def new
    @style_group = StyleGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @style_group }
    end
  end

  # GET /style_groups/1/edit
  def edit
    @style_group = StyleGroup.find(params[:id])
  end

  # POST /style_groups
  # POST /style_groups.json
  def create
    @style_group = StyleGroup.new(params[:style_group])

    respond_to do |format|
      if @style_group.save
        format.html { redirect_to @style_group, notice: 'Style group was successfully created.' }
        format.json { render json: @style_group, status: :created, location: @style_group }
      else
        format.html { render action: "new" }
        format.json { render json: @style_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /style_groups/1
  # PUT /style_groups/1.json
  def update
    @style_group = StyleGroup.find(params[:id])

    respond_to do |format|
      if @style_group.update_attributes(params[:style_group])
        format.html { redirect_to @style_group, notice: 'Style group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @style_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /style_groups/1
  # DELETE /style_groups/1.json
  def destroy
    @style_group = StyleGroup.find(params[:id])
    @style_group.destroy

    respond_to do |format|
      format.html { redirect_to style_groups_url }
      format.json { head :no_content }
    end
  end
end
