class Api::ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end

  protected

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded_token = JWT.decode header, Rails.credentials.secret_key_base, true, algorithm: 'HS256'
    payload = decoded_token[0]
    @auth_user = User.find_by(id: payload['id']) if payload && payload['id']
  rescue JWT::VerificationError
    render json: {
      msg: 'Invalid Token'
    }
  end

  def handle_access_denied(exception)
    redirect_to root_url, alert: exception.message
  end
end
