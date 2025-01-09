class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:new]
  def new
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id])
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || posts_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy 
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
