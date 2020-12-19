class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params_parsed)
    units = Unit.where(id: params[:booking][:unit_id]) if params[:booking][:unit_id]
    units.each do |unit|
      @booking.units << unit
    end

    respond_to do |format|
      if @booking.save
        if user_signed_in?
          units.each do |unit|
            @booking.update user: current_user, units: [ unit ]
          end
        else
          cookies[:booking_id] = @booking.id
        end
        format.html { redirect_to checkout_index_path, notice: 'Booking was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    redirect_to checkout_index_path, flash: { success: 'Booking was successfully destroyed.' } 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(
        :start_date,
        :end_date,
        :amount,
        :payment_status,
        :guests,
        :date
      )
    end

    def booking_params_parsed
      {
        start_date: DateTime.parse(booking_params[:date].split(" - ")[0]),
        end_date: DateTime.parse(booking_params[:date].split(" - ")[1]),
        adult_capacity: JSON.parse(booking_params[:guests])['adult_count'],
        child_capacity: JSON.parse(booking_params[:guests])['child_count'],
        user_id: user_signed_in? ? current_user.id : nil
      }
    end
end
