class GearsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gear, only: %i[show edit update destroy]

  def index
    @gears = Gear.all
    @gears = policy_scope(Gear)
    @markers = @gears.geocoded.map do |gear|
      {
        lat: gear.latitude,
        lng: gear.longitude
      }
    end
  end

  def show
    authorize @gear
  end

  def new
    @gear = Gear.new
    authorize @gear
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.user = current_user
    authorize @gear
    if @gear.save
      redirect_to gear_path(@gear)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @gear
  end

  def update
    authorize @gear
    if @gear.update(gear_params)
      redirect_to gear_path(@gear)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @gear
    @gear.destroy
    redirect_to user_gears_path(current_user)
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :description, :price, :category, :photo, :address)
  end

  def set_gear
    @gear = Gear.find(params[:id])
  end
end
