require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without first_name' do
    u = User.new
    assert u.save
  end

  test 'should validate password length'
end
