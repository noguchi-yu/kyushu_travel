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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿が更新されました'
      redirect_to post_path(@post)
    else
      flash.now[:danger] = '投稿を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    flash[:success] = '投稿が削除されました'
    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :body)
  end
end
