class ScoreboardsController < ApplicationController
  def index
    @top_users = Message.where(created_at: Date.today.all_week).includes(:user).group_by{it.user}
  end
end
