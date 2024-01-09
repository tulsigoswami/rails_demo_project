# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:type) }

    it {
      should allow_value('Junkook').for(:first_name)
      should_not allow_value('Junkook$').for(:first_name)
    }

    it {
      should allow_value('Jeon').for(:last_name)
      should_not allow_value('Jeon$').for(:last_name)
    }

    it {
      should allow_value('jk@gmail.com').for(:email)
      should_not allow_value('junkook1@').for(:email)
    }
  end

  describe 'Associations' do
    it { should have_secure_password }
    it { should have_one_attached(:profile_image) }
    it { should have_many(:recipes) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:followed_users).with_foreign_key(:follower_id).class_name('Follow') }
    it { should have_many(:followees).through(:followed_users) }
    it { should have_many(:following_users).with_foreign_key(:followee_id).class_name('Follow') }
    it { should have_many(:followers).through(:following_users) }
  end

  describe 'Methods' do
    let(:user) { create(:user) }

    it 'generates a password token' do
      user.generate_password_token!
      expect(user.reset_password_token).to_not be_nil
      expect(user.reset_password_sent_at).to be_within(1.minute).of(Time.now.utc)
    end

    it 'checks if the password token is valid' do
      user.reset_password_sent_at = 3.hours.ago
      expect(user.password_token_valid?).to be true
    end

    it 'resets the password' do
      user.reset_password!('new_password')
      expect(user.reset_password_token).to be_nil
      expect(user.password_digest).to_not be_nil
    end
  end

  describe 'Private Methods' do
    it 'generates a token' do
      user = create(:user)
      token = user.send(:generate_token)
      expect(token).to_not be_nil
    end
  end
end
