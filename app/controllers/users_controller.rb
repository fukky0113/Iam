class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:name, :user_id, :password, :password_confirmation)
    end
end
