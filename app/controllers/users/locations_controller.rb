class Users::LocationsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(location_params)

    redirect_to edit_user_gender_path
  end

  private

  def location_params
    params.require(:user).permit(:location)
  end
end
