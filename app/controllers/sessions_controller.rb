class SessionsController < ApplicationController
  # ログアウト時のみ動作可能
  before_action :logged_out_user, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id])
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]

      # セッション固定攻撃対策
      reset_session

      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || posts_path, status: :see_other
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy 
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
