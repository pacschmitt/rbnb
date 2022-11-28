class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gear

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to gear_path(@gear)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @nooking.destroy
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_gear
    @gear = Gear.find(params[:gear_id])
  end
end
