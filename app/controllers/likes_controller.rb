class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = post.likes.build(author: current_user)

    flash[:error] = 'Unable to like post.' unless like.save
    redirect_to user_post_path(current_user, post)
  end
end
