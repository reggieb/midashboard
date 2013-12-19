require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_admin
    assert_equal true, users(:admin).admin?
  end
  
  def test_not_admin
    assert_not_equal true, users(:user).admin?
  end
end
