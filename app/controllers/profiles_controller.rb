class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find_by_param(params[:user_id])
    @profile = @user.profile
  if
    @profile.update_attributes(profile_params)
    flash[:success] = "Profile updated"
    redirect_to @user
  else
    flash.now[:error] = "Incorrect submission"
      render 'edit'
    end
  end


  def edit
    @user = current_user
    @profile = @user.profile
  end

  private

    def profile_params
      params.require(:profile).permit(:about, :type_of_lifter, :location)
    end
end