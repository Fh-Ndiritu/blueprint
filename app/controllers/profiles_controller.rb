class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update ]
  before_action :authorize_profile, only: %i[ edit update]


  # GET /profiles/1 or /profiles/1.json
  def show
    # redirect_to edit_profile_path
  end

  # GET /profiles/1/edit
  def edit
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_path, notice: "Profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      # this is a user viewing someone else's profile
      @profile = if params[:user_id]
         Profile.find_or_create_by(user: params[:user_id])
      else
        # this must be the user
        Profile.find_or_create_by(user: current_user)
      end
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.expect(profile: [ :name, :avatar, :bio ])
    end

    def authorize_profile
      redirect_to root_path unless current_user == @profile.user
    end
end
