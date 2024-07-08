class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage]

  def mypage
    @user = current_user
    @users_posts = @user.posts.order(created_at: :desc).page(params[:page])
  end
end
