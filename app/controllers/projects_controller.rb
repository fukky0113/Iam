class ProjectsController < ApplicationController
  def new
    @project = Project.new

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def create
    @project = Project.new(project_params)
    # ポスト可能ユーザーを限定
    @project.user_id = User.first.id

    if @project.valid?
      @project.save

    else
      render 'new', status: :unprocessable_entity
    end

    # if @project.save
    #     redirect_to posts_path, status: :see_other
    # else
    #   render 'new', status: :unprocessable_entity
    # end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  def edit
    @project = Project.find(params[:id])

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to posts_path, status: :see_other
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:summary, :incharge, :achivement, :user_id, :company_id, skill_id: [])
  end

end
