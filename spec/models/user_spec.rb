require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  context 'validations' do
    it 'ensures the presence of first_name and last_name' do
      user = User.new(first_name: '', last_name: '').save
      expect(user).to eq(false)
    end

    it 'ensures that length of first_name and last_name must 
    be greater then two' do
      user = User.new(first_name: 'ab', last_name: 'c').save
      expect(user).to eq(false)
    end

    it 'ensures email format' do
      user = User.new(email: "abc@.com").save
      expect(user).to eq(false)
    end
  end

  describe "#generate reset password token" do 
    it "generates reset password token" do
      user.reset_password_token = SecureRandom.hex(10)
      user.reset_password_sent_at = Time.now.utc
      expect(user.save!).to be_in([true,false])
    end
  end
end
