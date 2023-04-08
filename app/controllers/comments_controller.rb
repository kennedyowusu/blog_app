Class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = 'Comment Created Successfully'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:success] = 'Comment Not Created'
      render :new, status: :unprocessable_entity
    end
  end
