require 'test_helper'

class DashboardGroupTest < ActiveSupport::TestCase
  def setup
    @dashboard = dashboards(:one)
  end
  
  def test_join_to_user_group
    user_group = user_groups(:one)
    user_group.dashboards << @dashboard
    assert_equal [@dashboard], user_group.dashboards 
  end
  
  def test_join_to_user
    user = users(:user)
    user.dashboards << @dashboard
    assert_equal [@dashboard], user.dashboards 
  end
  
  
end
