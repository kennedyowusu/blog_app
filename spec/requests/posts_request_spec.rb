require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /posts' do
    it 'returns successful with http status code 200' do
      get posts_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Display All Post')
    end
  end

  describe 'GET /posts/:id' do
    it 'returns successful with http status code 200' do
      get '/posts/1'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Show Single Post')
    end
  end
end
