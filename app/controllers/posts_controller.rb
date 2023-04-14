class PostsController < ApplicationController
  before_action :find_user, only: %i[index show new create]

  def index
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to user_posts_path(@user)
    else
      flash[:danger] = 'Post not created!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
