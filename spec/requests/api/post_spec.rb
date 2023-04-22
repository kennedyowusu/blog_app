require 'jwt'

class Api::PostsController < Api::ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  before_action :find_user

  # Get a list of posts for a given user
  #
  # GET /api/users/:user_id/posts
  #
  # Parameters:
  # - user_id (required, integer, path) - ID of the user whose posts to retrieve
  #
  # Responses:
  # - 200 (application/json) - A list of posts for the given user
  # - 404 (application/json) - User not found
  #
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
