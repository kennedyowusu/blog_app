require 'jwt'

class Api::LoginController < Api::ApplicationController
  skip_before_action :authenticate_user

  def index
    @user = User.find_by_email(login_params[:email])

    if @user&.valid_password?(login_params[:password])
      payload = {
        id: @user.id,
        name: @user.name,
        email: @user.email
      }
      token = JWT.encode payload, jwt_secret_key, 'HS256'
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def jwt_secret_key
    Rails.application.credentials.jwt_secret_key
  end
end
