class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!


  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      root_path
    else
      stored_location_for(resource) || super
    end
  end

  def after_sign_out_path_for(resource)
    welcome_path
  end
end
