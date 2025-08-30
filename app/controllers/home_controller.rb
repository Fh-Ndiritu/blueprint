class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def welcome
  end

  def dashboard
    @your_groups = current_user.groups
    @other_groups = Group.excluding(@your_groups)
    @current_group = @your_groups&.first || @other_groups.first
  end
end
