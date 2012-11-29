class SessionsController < ApplicationController
  def new

  end

  def create
    if session[:user_id] = User.authenticate(params[:name], params[:password]).try(:id)
      redirect_to stored_path, notice: "Welcome #{current_user.name}!"
    else
      render action: 'new', warning: "Log in unsuccessful"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: 'You have been successfully logged out!'
  end
end
