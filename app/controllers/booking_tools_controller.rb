class BookingToolsController < ApplicationController
  # GET /booking_tools
  # GET /booking_tools.json
  def index
    @booking_tools = BookingTool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booking_tools }
    end
  end

  # GET /booking_tools/1
  # GET /booking_tools/1.json
  def show
    @booking_tool = BookingTool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @booking_tool }
    end
  end

  # GET /booking_tools/new
  # GET /booking_tools/new.json
  def new
    @booking_tool = BookingTool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking_tool }
    end
  end

  # GET /booking_tools/1/edit
  def edit
    @booking_tool = BookingTool.find(params[:id])
  end

  # POST /booking_tools
  # POST /booking_tools.json
  def create
    @booking_tool = BookingTool.new(params[:booking_tool])

    respond_to do |format|
      if @booking_tool.save
        format.html { redirect_to @booking_tool, notice: 'Booking tool was successfully created.' }
        format.json { render json: @booking_tool, status: :created, location: @booking_tool }
      else
        format.html { render action: "new" }
        format.json { render json: @booking_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booking_tools/1
  # PUT /booking_tools/1.json
  def update
    @booking_tool = BookingTool.find(params[:id])

    respond_to do |format|
      if @booking_tool.update_attributes(params[:booking_tool])
        format.html { redirect_to @booking_tool, notice: 'Booking tool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_tools/1
  # DELETE /booking_tools/1.json
  def destroy
    @booking_tool = BookingTool.find(params[:id])
    @booking_tool.destroy

    respond_to do |format|
      format.html { redirect_to booking_tools_url }
      format.json { head :no_content }
    end
  end
end
