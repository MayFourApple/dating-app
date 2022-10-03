class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    return edit_user_location_path if resource.location.blank?
    return edit_user_gender_path if resource.gender.blank?

    dashboard_path
  end
end
