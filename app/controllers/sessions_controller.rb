class SessionsController < ApplicationController
  def new

  end

  def create
    if session[:user] = User.authenticate(params[:name], params[:password])
      redirect_to root_url, notice: "Welcome #{session[:user].name}!"
    else
      render action: 'new', warning: "Login unsuccessful"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: 'You have been successfully signed out!'
  end
end
