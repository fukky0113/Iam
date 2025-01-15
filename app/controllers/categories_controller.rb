class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :admin_user, only: [:new, :create, :destroy]

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_category_path
    else
      @categories = Category.all
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    return if Post.find_by(category_id: params[:id])

    Category.find(params[:id]).destroy
    redirect_to new_category_path
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end
end
