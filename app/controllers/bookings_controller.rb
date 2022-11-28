class BookingsController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!
  before_action :set_gear

  def index
    @bookings = Booking.all
  end

  def new
=======
  def new
    @gear = Gear.find(params[:gear_id])
>>>>>>> 09c05c7cfe85880f4e4c9c38d3ac22f34e85d790
    @booking = Booking.new
  end

  def create
<<<<<<< HEAD
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to gear_path(@gear)
=======
    @gear = Gear.find(params[:gear_id])
    @booking.gear = @gear
    @booking.user = current_user
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @gear
>>>>>>> 09c05c7cfe85880f4e4c9c38d3ac22f34e85d790
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
<<<<<<< HEAD
    @nooking.destroy
    redirect_to root_path
=======
    @booking = Booking.find(params[:id])
    @booking.delete
    redirect_to gears_path
>>>>>>> 09c05c7cfe85880f4e4c9c38d3ac22f34e85d790
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
<<<<<<< HEAD

  def set_gear
    @gear = Gear.find(params[:gear_id])
  end
=======
>>>>>>> 09c05c7cfe85880f4e4c9c38d3ac22f34e85d790
end
