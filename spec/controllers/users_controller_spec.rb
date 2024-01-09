require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe "GET#index" do
		let(:user) { create(:user, type: 'Admin') }
		let(:token) { JsonWebToken.encode(user_id: user.id ) }

		it "with valid token render users successfully" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers
			get :index
			expect(response).to have_http_status(:ok) 
		end

		it "without token it should give unauthorized error" do
			headers = {'Authorization' => " "}
			request.headers.merge! headers
			get :index
			expect(response).to have_http_status(:unauthorized) 
		end
	end

	describe 'POST#create' do
		let(:user) { create(:user, type: 'User') }
		it "registers a user with valid params" do
		  post :create, params: { first_name:Faker::Name.initials(number: 5) , last_name: Faker::Name.initials(number: 5), email:"#{Faker::Name.initials(number: 5)}@gmail.com", password: "12ASfeffe%34" }
		  expect(response).to have_http_status(:created)
		end

		it "does not register a user with invalid params" do
			post :create, params: {first_name: "@#w", last_name:"abcd"}
			expect(response.body).to eq('Please input the correct information')
		end

		it "does not create a user with existing email" do
			post :create, params: { first_name:Faker::Name.initials(number: 5) , last_name: Faker::Name.initials(number: 5), email: user.email, password: "12ASfeffe%34" }
			expect(response.message).to eq("Conflict")
		end
	end

	describe 'GET#users_profile' do
		let(:user) { create(:user, type: 'User') }
		let(:token) { JsonWebToken.encode(user_id: user.id ) }

		it "returns all user with valid params" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers
			get :users_profile

		  expect(response).to have_http_status(:success)
		  expect(response.content_type).to eq('application/json; charset=utf-8')
		end
	end

	describe 'POST#follow' do
		let(:user1) { create(:user, type: 'User') }
		let(:user2) { create(:user, type: 'User') }
		let(:token) { JsonWebToken.encode(user_id: user1.id ) }

		it "with valid token follow a user" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers
			post :follow, params: { id: user2.id }
      expect(user1.followees).to include(user2)
		end
	end

	describe 'POST#unfollow' do
		let(:user1) { create(:user, type: 'User') }
		let(:user2) { create(:user, type: 'User') }
		let(:token) { JsonWebToken.encode(user_id: user1.id ) }

		it "with valid token unfollow a user" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers
			post :unfollow, params: { id: user2.id }
      expect(user1.followees).not_to include(user2)
		end
	end

	describe 'GET#all_followees' do
		let(:user) { create(:user, type: 'User') }
		let(:token) { JsonWebToken.encode(user_id: user.id ) }

		it "get all the followees with valid token" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers

			get :all_followees
			expect(response).to have_http_status(:ok)
		end
	end

	describe 'GET#all_followers' do
		let(:user) { create(:user, type: 'User') }
		let(:token) { JsonWebToken.encode(user_id: user.id ) }

		it "get all the followers with valid token" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers

			get :all_followers
			expect(response).to have_http_status(:ok)
			expect(response.content_type).to eq('application/json; charset=utf-8')
		end
	end
end