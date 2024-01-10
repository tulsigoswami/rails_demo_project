require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
	describe "GET#index" do
		let (:user) { create(:user) }
		let (:user_token) { JsonWebToken.encode(user_id: user.id) }

		it "renders all recipes successfully when user is logged in" do
			headers = {'Authorization' => "#{user_token}"}
			request.headers.merge! headers
			get :index
			expect(response.content_type).to eq('application/json; charset=utf-8')
		end
	end

	describe "POST#create" do
		let (:user) { create(:user) }
		let (:token) { JsonWebToken.encode(user_id: user.id) }

		context "with valid token and valid params" do
			it "creates recipe and returns data" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				post :create, params: { title: 'recipe1', description: 'a food without wood', user_id:user.id}
				expect(response.content_type).to eq('application/json; charset=utf-8')
			end
		end

		context "with valid token but invalid params" do
			it "does not create a recipe" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				post :create, params: { title: '', description: 'a food without wood', user_id:user.id}
				
				json_response = JSON.parse(response.body)
				expect(json_response).to include("Title can't be blank")
				expect(response.content_type).to eq('application/json; charset=utf-8')
			end
		end
	end

	describe "PUT#update" do
		let (:user) { create(:user) }
		let (:recipe) { create(:recipe, user_id: user.id) }
		let (:token) { JsonWebToken.encode(user_id: user.id) }

		context "when token is valid" do
			it "updates the recipe attributes with valid params if recipe present" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				put :update, params: { id: recipe.id, title: "veg noodles", decription: "chinese dish"}
				expect(response).to have_http_status(200)
				expect(response.content_type).to eq('application/json; charset=utf-8')
			end

			it "give no content when recipe id not found" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				put :update, params: { id: " ", title: "veg noodles", decription: "chinese dish"}
				expect(response.status).to eq 204
			end
		end
	end

	describe "GET#show" do
		let (:user) { create(:user) }
		let (:recipe) { create(:recipe, user_id: user.id) }
		let (:token) { JsonWebToken.encode(user_id: user.id) }

		context "with valid token" do
			it "finds the recipe if present and returns it" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				get :show, params: { id: recipe.id}
				expect(response.content_type).to eq('application/json; charset=utf-8')
			end

			it "returns no-content if recipe not found" do
				headers = {'Authorization' => "#{token}"}
				request.headers.merge! headers
				get :show, params: { id: ''}
				expect(response).to have_http_status(204)
		  end
		end
	end

	describe "DELETE#destroy" do
		let (:user) { create(:user) }
		let (:recipe) { create(:recipe, user_id: user.id) }
		let (:token) { JsonWebToken.encode(user_id: user.id) }

		it "deletes a recipe with valid token" do
			headers = {'Authorization' => "#{token}"}
			request.headers.merge! headers
			delete :destroy, params: { id: recipe.id}
			expect(response.body).to include('Recipe deleted successfully')
		end
	end
end