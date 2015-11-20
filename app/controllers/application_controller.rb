class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    User.find_by(session_token: session[:session_token])
  end

  def login_user(user)
    session[:session_token] = user.reset_session_token
  end

  def logout_user(current_user)
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def redirect_to_user_profile
    redirect_to user_url(current_user) if current_user
  end

  def redirect_to_login
    redirect_to new_session_url unless current_user
  end

end
