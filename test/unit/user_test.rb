require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_admin
    assert_equal true, users(:admin).admin?
  end
  
  def test_not_admin
    assert_not_equal true, users(:user).admin?
  end
  
  def test_all_dashboard_ids
    user = users(:user)
    d1 = dashboards(:one)
    d2 = dashboards(:two)
    
    user.dashboards << d1
    user.user_groups.first.dashboards << d2
    assert_equal([d1.id, d2.id].sort, user.all_dashboard_ids.sort)
  end
end
