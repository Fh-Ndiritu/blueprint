class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome

  def welcome
  end

  def dashboard
    @your_groups = current_user.groups
    @other_groups = Group.excluding(@your_groups)
    set_current_group
  end

  private

  def set_current_group
    if params[:current_id].present?
      group = Group.find(params[:current_id])
      if @your_groups.exists?(group.id)
        @current_group = group
      else
        flash.now.alert = "Request to join first."

        #  flash.alert = "This is shown on the next redirect too"
      end
    elsif @your_groups.any?
      @current_group = @your_groups.first
    end
  end
end
