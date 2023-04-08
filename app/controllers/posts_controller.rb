class PostsController < ApplicationController
  # def index
  #   @user = User.find(params[:user_id])
  #   @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 1)
  # end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.try(:order, created_at: :desc).try(:paginate, page: params[:page], per_page: 1) || []
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
