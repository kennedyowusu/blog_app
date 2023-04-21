require 'jwt'
class Api::PostsController < Api::ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  before_action :find_user

  def index
    @posts = @user.posts.order(created_at: :asc)
    render json: @posts
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def user_not_found
    render json: { status: 'Failure', error: 'User Not Found' }, status: :not_found
  end
end
