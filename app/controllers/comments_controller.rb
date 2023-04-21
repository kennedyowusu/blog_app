class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create destroy]
  before_action :set_comment, only: [:destroy]
  load_and_authorize_resource

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
