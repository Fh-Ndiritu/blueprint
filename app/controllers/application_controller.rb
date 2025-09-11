class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :verify_profile


  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if resource.name.present?
        root_path
      else
        edit_profile_path(resource)
      end
    else
      stored_location_for(resource) || super
    end
  end

  def after_sign_out_path_for(resource)
    welcome_path
  end

  def verify_profile
    return if request.url.include?("profile") || !user_signed_in?

    redirect_to edit_profile_path(current_user) unless current_user.name.present?
  end
end
