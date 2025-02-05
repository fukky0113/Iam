class UserSkillsController < ApplicationController
  def new
    @user_skills = UserSkill.new
    @user = User.find(params[:user_id])
  end

  def create
    @user_skills = UserSkill.new(user_skills_params)

    # ポスト可能ユーザーを限定
    @user_skills.user_id = current_user.id
    if @user_skills.save
      redirect_to posts_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
    def user_skills_params
      params.require(:user_skill).permit(:user_id, :skill_id, :detail)
    end

end
