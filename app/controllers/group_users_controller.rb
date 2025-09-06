class GroupUsersController < ApplicationController
  include Groupable
  before_action :set_group_user, only: %i[ edit destroy ]
  before_action :fetch_groups, only: :destroy

  # GET /group_users/new
  def new
    @group_user = GroupUser.new
  end

  # POST /group_users or /group_users.json
  def create
    @group_user = GroupUser.new(group_user_params)

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to root_path(current_id: @group_user.group_id), notice: "You have joined the group!" }
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

      # here we need to define a turbo request
      # why?
      # because we need to move the group out of the member group and also revoke access to groups
      # we can stream a change to partials that will be affected

      # we need to ask ourselves what will change if we accessed the default page for this?
      # this a member group so we shall access it from group show path
      # losing access mean the button needs to change

      format.turbo_stream do
        # action, target, partial, locals is the pattern
        render turbo_stream: turbo_stream.update(:group, partial: "groups/group", locals: { group: @group_user.group }) +
        turbo_stream.replace(:current_group, partial: "home/main_content", locals: {current_group: @group_user.group}) +
        turbo_stream.replace(:sidebar_left, partial: "home/sidebar_left", locals: { other_groups: @other_groups, your_groups: @your_groups })

        # now we handle cases where this turbo frame might be reused like the dashboard page
        # if you leave a group, you can't see messages or even add a message option
        # we can chain turbo renders
      end

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
