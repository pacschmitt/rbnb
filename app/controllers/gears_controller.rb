class GearsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gear, only: %i[show edit update destroy]

  def index
    @gears = Gear.all
    @gears = policy_scope(Gear)
    if params[:query].present?
      unless Gear.near(params[:query], 20).nil?
        @gears = Gear.near(params[:query], 20)
      else
        @gears = Gear.global_search(params[:query])
      end
      # sql_query = <<~SQL
      #   gears.name @@ :query
      #   OR gears.description @@ :query
      #   OR gears.category @@ :query
      #   OR gears.address @@ :query
      #   OR users.first_name @@ :query
      #   OR users.last_name @@ :query
      # SQL
      # @gears = Gear.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @gears = Gear.all
    end
    @markers = @gears.geocoded.map do |gear|
      {
        lat: gear.latitude,
        lng: gear.longitude
      }
    end
  end

  def show
    authorize @gear
    image_bg
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
      flash.alert = "You've created a new Gear"
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
      flash.alert = "You've Updated your post: #{@gear.name}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @gear
    @gear.destroy
    redirect_to user_path(current_user)
    flash.alert = "You've Deleted your #{@gear.name}"
  end

  private

  def gear_params
    params.require(:gear).permit(:name, :description, :price, :category, :photo, :address)
  end

  def set_gear
    @gear = Gear.find(params[:id])
  end

  def image_bg
    case
    when @gear.category == "Cycling"
      @image = "cycling"
    when @gear.category == "Winter-Sports"
      @image = "winter"
    when @gear.category == "Outdoors"
      @image = "outdoor"
    when @gear.category == "Racket-Sports"
      @image = "racket"
    when @gear.category == "Team-Sports"
      @image = "team"
    when @gear.category == "Water-Sports"
      @image = "water"
    when @gear.category == "Exercice"
      @image = "gym"
    when @gear.category == "Golf"
      @image = "golf"
    when @gear.category == "Precision-Sports"
      @image = "precision"
    when @gear.category == "Skates&Skateboards"
      @image = "skates"
    else
      @image = "defaultbanner"
    end
  end
end
