class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user
    @user = User.find(params[:id])
    @gears = @user.gears
  end
end
