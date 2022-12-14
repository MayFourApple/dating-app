class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @schedules = current_user.schedules
  end

  def new
    @schedule = current_user.schedules.new
    @schedule = Schedule.new(params[:schedule])
  end

  def create
    @schedule = current_user.schedules.new
    @schedule.update(schedule_params)

    if @schedule.valid?
      redirect_to dashboard_path
    else 
      render :new, status: 422
    end
  end

  def show
    @schedule.find(schedule_params[:id])
    @schedule.destroy

    redirect_to schedules_path
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    redirect_to schedules_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:availability, :location, :gender)
  end
end
