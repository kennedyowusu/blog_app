class CommentsController < ApplicationController
  before_action :find_post, only: %i[create edit update destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    flash[:success] = 'Commented!'
    redirect_to user_posts_path(current_user)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
