class SessionsController < ApplicationController

  def new
  end

  def create
  
   if params[:user] && user = User.authenticate_with_credentials(params[:user][:email], params[:user][:password])
      session[:user_id] = user.id
      redirect_to '/', notice: 'Welcome!'
    else
      redirect_to '/login', notice: 'Please enter valid email and password, or create new account!'
     end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end