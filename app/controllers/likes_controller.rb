Class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    @like.post_id = params[:post_id]
    if @like.save
      flash[:success] = 'Post Liked Successfully'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:success] = 'Like Not Created'
      render :new, status: :unprocessable_entity
    end
  end
