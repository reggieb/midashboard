require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  
  def test_setup
    assert_equal [users(:user)], user_groups(:one).users
  end
  
end
