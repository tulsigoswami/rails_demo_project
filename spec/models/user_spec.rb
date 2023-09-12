require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it "ensures the presence of first_name and last_name" do
      user = User.new(first_name: "",last_name:"").save
      expect(user).to eq(false)
    end

    it "ensures that length of first_name and last_name must be greater then two" do
      user = User.new(first_name: "ab",last_name:"c").save
      expect(user).to eq(false)
    end


  end
end
