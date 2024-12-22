class PostsController < ApplicationController
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

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
