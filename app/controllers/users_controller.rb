class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by_param(params[:id])
  end
end
