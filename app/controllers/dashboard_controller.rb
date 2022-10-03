class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @matches = current_user.matches.group_by { |m| "#{m.availability} #{m.location}" }
  end
end
