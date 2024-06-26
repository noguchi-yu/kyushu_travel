class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[show new create edit update destroy]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    params[:post].delete(:images) if params[:post][:images].all?(&:blank?)

    if @post.update(post_params)
      redirect_to post_path(@post), success: t('defaults.flash_message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    flash[:success] = '投稿が削除されました'
    redirect_to posts_path, success: t('defaults.flash_message.delete', item: Post.model_name.human), status: :see_other
  end

  def show
    @post = Post.includes(:user).find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :body, :images_cache, :latitude, :longitude, :web_site, images: [], tag_ids: [])
  end
end
