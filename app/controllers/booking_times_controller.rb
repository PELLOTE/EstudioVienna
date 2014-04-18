class BookingTimesController < ApplicationController
  # GET /booking_times
  # GET /booking_times.json
  def index
    @booking_times = BookingTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @booking_times }
    end
  end

  # GET /booking_times/1
  # GET /booking_times/1.json
  def show
    @booking_time = BookingTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @booking_time }
    end
  end

  # GET /booking_times/new
  # GET /booking_times/new.json
  def new
    @booking_time = BookingTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @booking_time }
    end
  end

  # GET /booking_times/1/edit
  def edit
    @booking_time = BookingTime.find(params[:id])
  end

  # POST /booking_times
  # POST /booking_times.json
  def create
    @booking_time = BookingTime.new(params[:booking_time])

    respond_to do |format|
      if @booking_time.save
        format.html { redirect_to @booking_time, notice: 'Booking time was successfully created.' }
        format.json { render json: @booking_time, status: :created, location: @booking_time }
      else
        format.html { render action: "new" }
        format.json { render json: @booking_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /booking_times/1
  # PUT /booking_times/1.json
  def update
    @booking_time = BookingTime.find(params[:id])

    respond_to do |format|
      if @booking_time.update_attributes(params[:booking_time])
        format.html { redirect_to @booking_time, notice: 'Booking time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_times/1
  # DELETE /booking_times/1.json
  def destroy
    @booking_time = BookingTime.find(params[:id])
    @booking_time.destroy

    respond_to do |format|
      format.html { redirect_to booking_times_url }
      format.json { head :no_content }
    end
  end
end
