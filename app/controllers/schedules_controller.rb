class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @schedules = current_user.schedules
  end

  def new
    @schedule = current_user.schedules.new
  end

  def create
    @schedule = current_user.schedules.new
    @schedule.update(schedule_params)

    redirect_to dashboard_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:availability, :location, :gender)
  end
end
