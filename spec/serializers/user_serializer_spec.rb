require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
	describe "serializer" do
		@user = create(:user)
		@serializer = UserSerializer.new(user)
		@serialization = ActiveModelSerializers::Adapter.create(@serializer)

	  it "should return the first_name" do
			subject { JSON.parse(@serialization.to_json) }
			expect(subject.first_name).to eq(user.first_name)
		end
	end
end