class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  before_action :admin_user, only: [:new, :create, :destroy, :edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @category = @post.category
  end

  def index
    @post = Post.all
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, status: :see_other
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :category_id)
    end
end
