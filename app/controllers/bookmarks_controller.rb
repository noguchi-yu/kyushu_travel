class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    post = Post.find(params[:post_id])
    current_user.bookmark(post)
    redirect_back(fallback_location: post_path(post), success: t('.success'))
  end

  def destroy
    post = current_user.bookmarks.find(params[:id]).post
    current_user.unbookmark(post)
    redirect_back(fallback_location: post_path(post), success: t('.success'), status: :see_other)
  end
end
