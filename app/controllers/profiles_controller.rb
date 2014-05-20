class ProfilesController < ApplicationController

  def edit
    @user = current_user
    @profile = @user.profile
  end

  private

    def profile_params
      params.require(:profile).permit(:about)
    end
end