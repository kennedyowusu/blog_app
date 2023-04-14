class LikesController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
    @like = @post.likes.new(user: current_user)
    @like.save
    flash[:success] = 'Liked!'
    redirect_to user_posts_path(current_user)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
