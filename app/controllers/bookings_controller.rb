class BookingsController < ApplicationController
  def new
    @gear = Gear.find(params[:gear_id])
    @booking = Booking.new
  end

  def create
    @gear = Gear.find(params[:gear_id])
    @booking.gear = @gear
    @booking.user = current_user
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @gear
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.delete
    redirect_to gears_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
