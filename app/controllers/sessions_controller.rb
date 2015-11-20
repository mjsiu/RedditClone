class SessionsController < ApplicationController

  before_action :redirect_to_user_profile, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      # show errors
      render :new
    else
      login_user(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout_user(current_user)
    redirect_to new_session_url
  end


end
