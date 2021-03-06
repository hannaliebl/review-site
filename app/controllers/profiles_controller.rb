class ProfilesController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.find_by_param(params[:user_id])
    @profile = @user.build_profile
  end

  def create
    @user = User.find_by_param(params[:user_id])
    @profile = @user.build_profile(profile_params)
    if @profile.save
      if params[:skip]
        flash[:success] = "Welcome to How Many Squat Racks!"
      else
        flash[:success] = "Welcome to How Many Squat Racks!"
      end
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
    @user = User.find_by_param(params[:user_id])
    @profile = @user.profile
  end

  private

    def profile_params
      params.require(:profile).permit(:about, :lifter_type1, :lifter_type2, :lifter_type3, :lifter_type4, :lifter_type5, :lifter_type6, :location)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_url, notice: "Please log in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find_by_param(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
end