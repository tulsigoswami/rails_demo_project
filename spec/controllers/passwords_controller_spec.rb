require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
	describe "POST#forgot" do
		let(:user) { create(:user)}
		context "when email is not present or invalid" do
			it "shows email invalid message" do
				post :forgot, params: { email: " " } 
				expect(response.body).to include('Email not present')
			end

			it "shows email not available if email is not present" do
				post :forgot, params: { email: "abcd@gmail.com"}
				expect(response.body).to include("Email address not found. Please check and try again.")
				expect(response.message).to eq("Not Found")
			end
		end

		context "when email is valid & user is present" do
			it "generates password token" do
				post :forgot, params: { email: user.email }
				pass_token = user.generate_password_token!
				expect(user.reset_password_token).not_to eq(nil)
			end
		end
	end

	describe "POST#reset" do
		let(:user) { create(:user) }
		let(:token) { JsonWebToken.encode(user_id: user.id)}

		it "when email is blank gives token not present message" do
			post :reset, params: { email: " "}
			expect(response.body).to include('Token not present')
		end

		it "when user is present & token is not valid" do
			post :reset, params: { email: user.email, reset_password_token: "2bd570999e65124d6e39", password: user.password }
			expect(response.status).to eq(404)
		end

		it "when password is invalid" do
			reset_token = user.send(:generate_token)
			post :reset, params: { email: user.email, reset_password_token: reset_token, password: "12nen$%$3AAda" }
			expect(response).to have_http_status(404)
		end
	end
end