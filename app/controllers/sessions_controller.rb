class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id])
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy 
    log_out
    redirect_to root_url, status: :see_other
  end
end
