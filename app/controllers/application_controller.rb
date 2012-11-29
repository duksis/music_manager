class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_required
    return if session[:user_id]
    flash[:warning]='Please log in to continue'
    session[:return_to]=request['REQUEST_URI']
    redirect_to login_path
  end

  def stored_path
    session[:return_to] || root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
