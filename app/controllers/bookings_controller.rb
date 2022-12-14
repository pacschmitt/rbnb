class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gear, except: :destroy

  def index
    @bookings = Booking.all
    @bookings = policy_scope(Booking)
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
      flash.alert = "You've created a new Booking"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to root_path
    flash.alert = "You've Deleted your Booking"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_gear
    @gear = Gear.find(params[:gear_id])
  end
end
