require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
	let(:user) { create(:user) }
 	subject(:serialized_user) { described_class.new(user).as_json }

	it "should return the first_name" do
		expect(serialized_user).to include(
			first_name: user.first_name,
			last_name: user.last_name
			)
	end

	it "includes the recipe association" do
		create_list(:recipe, 3, user: user)
		expect(serialized_user[:recipes].count).to eq(3)
	end

	context 'when user has a profile image attached' do
		before do
			user.profile_image.attach(io: File.open('/home/abc/Downloads/abc.jpg'), filename: 'abc.jpg', content_type: 'image/jpeg' )
		end

		# it 'includes the user profile image' do
		# 	expect(serialized_user).to include(:user_profile => "/rails/active_storage/blobs...aHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--ea8409dd7a31b8fc9e9d4182f11ec672ae1bcbe0/abc.jpg")
		# end
	end
end

