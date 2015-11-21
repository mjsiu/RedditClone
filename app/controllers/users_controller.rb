class UsersController < ApplicationController

  before_action :redirect_to_user_profile, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors].user.full_messages
      render :new
    end
  end

  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
