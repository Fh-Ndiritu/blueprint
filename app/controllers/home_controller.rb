class HomeController < ApplicationController
  include Groupable
  skip_before_action :authenticate_user!, only: :welcome
  before_action :fetch_groups, only: :dashboard

  def welcome
  end

  def dashboard

    set_current_group
  end

  private

  def set_current_group
    @current_group = Group.find_by(id: params[:current_id]).presence || @your_groups.first || @other_groups.first
    # if params[:current_id].present?

    #   if @your_groups.exists?(group.id)
    #     @current_group = group
    #   else
    #     flash.now.alert = "Request to join first."

    #     #  flash.alert = "This is shown on the next redirect too"
    #   end
    # elsif @your_groups.any?
    #   @current_group = @your_groups.first
    # end
  end
end
