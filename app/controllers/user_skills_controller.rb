class UserSkillsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :edit, :update]
  before_action :admin_user, only: [:new, :create, :destroy, :edit, :update]

  def new
    @user_skills = UserSkill.new

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def create
    @user_skills = UserSkill.new(user_skills_params)

    # ポスト可能ユーザーを限定
    @user_skills.user_id = User.first.id

    if @user_skills.save
      render template: "ProjectSkills/create"
      redirect_to posts_path, status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user_skills = UserSkill.find(params[:id])

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def update
    @user_skills = UserSkill.find(params[:id])

    if @user_skills.update(user_skills_params)
      redirect_to posts_path, status: :see_other
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    UserSkill.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def user_skills_params
    params.require(:user_skill).permit(:user_id, :skill_id, :detail)
  end
end
