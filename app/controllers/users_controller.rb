class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :new, :create, :show, :destroy] 
  before_action :correct_user, only: []
  before_action :admin_user, only: [:destroy, :show, :edit, :update, :new, :create, :index]

  def index 
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      redirect_to posts_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else 
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, status: :see_other
  end

  private
    def user_params
      params.require(:user).permit(:name, :user_id, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, status: :see_other
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
