class SessionsController < ApplicationController

#  def new
#  end

  def create

    @username = params[:username]

    if @username and @username == params[:password]
      session[:user_id] = @username
      redirect_to root_path, notice: "You are logged as '#{@username}'"
    else
      redirect_to root_path, alert: "Incorrect username/password pair"
    end
 
  end

  def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "You are logged off."
  end
end
