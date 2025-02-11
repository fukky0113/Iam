class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :new, :create, :show, :destroy, :profile] 
  before_action :admin_user, only: [:destroy, :show, :edit, :update, :new, :create, :index, :profile]

  def index 
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to posts_path, status: :see_other
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
      redirect_to posts_path, status: :see_other
    else 
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, status: :see_other
  end

    # profileのeditページ
    def profile
      @user = User.find(params[:id])
    end
  
  private
    def user_params
      params.require(:user).permit(:name, :user_id, :password, :password_confirmation, :profile, :image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
