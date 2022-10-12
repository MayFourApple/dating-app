class HomepageController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect_to root_path
    end
  end
end
