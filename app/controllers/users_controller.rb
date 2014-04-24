class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to How Many Squat Racks!"
      redirect_to @user
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
    @user = User.find_by_param(params[:id])
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
end
