class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: %i[index show new]
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.includes(:likes, :comments)
  end

  def show
    @likes = @post.likes
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path, success: 'Post created!'
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path, success: 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
