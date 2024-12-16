class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id])
    if user && user.authenticate(params[:session][:password])
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy 
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
