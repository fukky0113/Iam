class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :destroy]
  before_action :admin_user, only: [:new, :create, :destroy]

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
  end

  def index
    @post = Post.all
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
