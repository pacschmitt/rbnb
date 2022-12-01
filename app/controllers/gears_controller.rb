class GearsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gear, only: %i[show edit update destroy]

  def index
    @gears = Gear.all
    @gears = policy_scope(Gear)
    if params[:query].present?
      # sql_query = <<~SQL
      #   gears.name @@ :query
      #   OR gears.description @@ :query
      #   OR gears.category @@ :query
      #   OR gears.address @@ :query
      #   OR users.first_name @@ :query
      #   OR users.last_name @@ :query
      # SQL
      # @gears = Gear.joins(:user).where(sql_query, query: "%#{params[:query]}%")
      @gears = Gear.global_search(params[:query])
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
    # image = (cl_image_tag "dwl90cghmju94tsyc7b0z07wlbmq", width: 700, height: 400, crop: :scale)
    if @gear.category == "cycling"
      @image = "https://res.cloudinary.com/df2jp0y94/image/upload/v1669389420/cld-sample-2.jpg"
    else
      @image = "https://res.cloudinary.com/df2jp0y94/image/upload/c_crop,h_400,w_1506,x_0,y_550/v1669861095/photo-1471506480208-91b3a4cc78be_qcnsvw.jpg"
    end
  end
end
