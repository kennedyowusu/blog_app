class PostsController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @user.posts
  end

  def show
    @comments = @post.comments
    @likes = @post.likes
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_post_path(current_user, @post)
    else
      flash.alert = 'Post Not Created!'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
