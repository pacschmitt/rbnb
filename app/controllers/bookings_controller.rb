class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gear

  def index
    @bookings = Booking.all
  end

  def new
    @gear = Gear.find(params[:gear_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @gear = Gear.find(params[:gear_id])
    @booking.gear = @gear
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to @gear
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.delete
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
