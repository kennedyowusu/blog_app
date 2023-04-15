class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find_by(id: params[:post_id])
    @like = @post.likes.build(author: @user)
    @like.save!
    redirect_back(fallback_location: root_path)
  end
end
