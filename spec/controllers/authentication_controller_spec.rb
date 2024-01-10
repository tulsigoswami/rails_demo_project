require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
	describe "POST#login" do
		let(:user) { create(:user) }
		let(:token) { JsonWebToken.encode(user_id: user.id) }

		context "when user enters valid email and password" do
			it "authenticate the user and generates token" do
				post :login, params: { email: user.email, password: user.password}
				expect(response.message).to eq("OK")
				expect(user.reset_password_token).to be_nil
			end
		end

		context "when either email or password is invalid" do
			it "show unauthorized status" do
				post :login, params: { email: " ", password: user.password}
				expect(response.message).to eq("Unauthorized")
			end
		end
	end
end