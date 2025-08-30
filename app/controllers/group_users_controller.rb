class GroupUsersController < ApplicationController
  before_action :set_group_user, only: %i[ edit destroy ]

  # GET /group_users/new
  def new
    @group_user = GroupUser.new
  end

  # POST /group_users or /group_users.json
  def create
    @group_user = GroupUser.new(group_user_params)

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to root_path, notice: "You have joined the group!" }
        format.json { render :show, status: :created, location: @group_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_users/1 or /group_users/1.json
  def destroy
    @group_user.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "You have left the group!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_user
      @group_user = GroupUser.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def group_user_params
      {
        user_id: current_user.id,
        group_id: params[:group_id]
      }
    end
end
