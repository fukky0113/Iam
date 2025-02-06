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

  def show
  end

  def index
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def company_params
    params.require(:company).permit(:user_id, :company_name)
  end
end
