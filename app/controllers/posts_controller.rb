class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = if @user.posts.any?
               @user.posts.order(created_at: :desc)
             else
               []
             end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:danger] = 'Post not created!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
