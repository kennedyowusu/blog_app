require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    it 'returns successful with http status code 200' do
      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('List All Users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns successful with http status code 200' do
      get '/users/1'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Display Single User')
    end
  end
end
