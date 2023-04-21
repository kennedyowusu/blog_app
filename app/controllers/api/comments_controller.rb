require 'jwt'

class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource
  before_action :find_post, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound do |e|
    logger.error("Record not found: #{e}")
    render json: { status: 'Failure', error: 'Record Not Found' }, status: :not_found
  end

  rescue_from CanCan::AccessDenied do |e|
    logger.error("Access Denied: #{e}")
    render json: { status: 'Failure', error: 'Access Denied' }, status: :forbidden
  end

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        if @post
          @comments = Comment.where(post_id: params[:post_id])
          render json: @comments
        else
          render json: { status: 'Failure', error: 'Post Not Found' }, status: :not_found
        end
      end
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @auth_user
    @comment.post = @post

    if @comment.save
      render json: { status: 'Success', comment: @comment }, status: :created
    else
      logger.error("Comment not created: #{@comment}")
      render json: { status: 'Failure', error: 'Comment Not Created' }, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
