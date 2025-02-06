class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @companies = Company.all

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def create
    @company = Company.new(company_params)

    # ポスト可能ユーザーを限定
    @company.user_id = User.first.id
    if @company.save
      redirect_to new_user_company_path, status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    return if Project.find_by(company_id: params[:id])

    Company.find(params[:id]).destroy
    redirect_to new_user_company_path, status: :see_other
  end

  private

  def company_params
    params.require(:company).permit(:user_id, :company_name)
  end
end
