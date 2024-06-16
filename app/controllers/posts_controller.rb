class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = '投稿が作成されました'
      redirect_to posts_path
    else
      flash.now[:danger] = '投稿を作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :body)
  end
end
