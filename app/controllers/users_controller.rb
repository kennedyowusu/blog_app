class UsersController < ApplicationController
  def index
    # fetch all users
  end

  def show
    @user = User.find(params[:id]) || 'User not found'
  end
end
