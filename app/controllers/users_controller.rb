class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @gears = @user.gears
  end
end
