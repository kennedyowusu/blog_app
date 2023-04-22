require 'swagger_helper'

RSpec.describe 'api/login', type: :request do
  path '/api/login' do
    post do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      response '200', 'User logged in successfully' do
        schema type: :object,
               properties: {
                 token: { type: :string }
               },
               required: %w[token]
        let(:user) { { email: 'example@example.com', password: 'example' } }
        run_test!
      end
      response '401', 'Unauthorized access' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]
        let(:user) { { email: 'example@example.com', password: 'wrong_password' } }
        run_test!
      end
      response '404', 'User not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]
        let(:user) { { email: 'non_existing_email@example.com', password: 'non_existing_password' } }
        run_test!
      end
    end
  end
end
