class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.with_posts.order(created_at: :asc)
  end

  def show
    @user = User.with_posts_and_activities.find(params[:id])
  end
end
