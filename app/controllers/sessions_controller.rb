class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    # If the user exists AND the password entered is correct.
      if user = User.authenticate_with_credentials(params[:user][:email], params[:user][:password]) # Save the user id inside the browser cookie. This is how we keep the user 
        #logged in status
        session[:user_id] = user.id
      redirect_to '/'
      else
      # If user's login fails, redirect to login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
