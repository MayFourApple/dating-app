class MatchesController < ApplicationController
  def destroy
    RemovedMatch.create(
      schedule_1_id: params[:id],
      schedule_2_id: params[:self_schedule_id]
    )

    redirect_to '/dashboard'
  end
end
