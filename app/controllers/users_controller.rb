class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Fill out a profile (optional)"
      redirect_to  new_user_profile_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_param(params[:id])
  end

  def edit
    @user = User.find_by_param(params[:id])
  end

  def update
    user = User.find_by_param(params[:id]).try(:authenticate, params[:user][:current_password])
    if user && @user.update_attributes(user_params)
      flash[:success] = "Password changed successfully"
      redirect_to @user
    else
      flash.now[:error] = "Incorrect Old Password"
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_url, notice: "Please log in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find_by_param(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
