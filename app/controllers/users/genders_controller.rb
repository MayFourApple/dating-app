class Users::GendersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(gender_params)

    redirect_to dashboard_path
  end

  private

  def gender_params
    params.require(:user).permit(:gender)
  end
end
