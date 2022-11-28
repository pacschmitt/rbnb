class GearsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gear, only: %i[show edit update destroy]

  def index
    @gears = Gear.all
  end

  def show
  end

  def new
    @gear = Gear.new
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.user = current_user
    if @gear.save
      redirect_to gear_path(@gear)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gear.update(gear_params)
      redirect_to gear_path(@gear)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gear.destroy
    redirect_to root_path
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :description, :price, :category)
  end

  def set_gear
    @gear = Gear.find(params[:id])
  end
end
