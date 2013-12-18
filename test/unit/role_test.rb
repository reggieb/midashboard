require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  
  def test_role
    assert_equal roles(:admin), users(:two).role
  end
  
end
