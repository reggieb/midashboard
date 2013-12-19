require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:user)
    @admin = users(:admin)
    sign_in @admin
  end
  
  def test_user_access  
    sign_in @user
    assert_user_access_is_restricted
  end
  
  def test_logged_out_access
    sign_out @admin
    assert_user_access_is_restricted
  end
  
  def test_logout_user_access_to_show
    get :show, id: @user
    assert_response :success
  end
  
  def test_show
    get :show, id: @admin
    assert_response :success
  end
  
  def test_user_can_access_own_show_page
    sign_in @user
    get :show, id: @user
    assert_response :success
  end
  
  def test_user_access_to_other_show_page
    sign_in @user
    get :show, id: @admin
    assert_response :redirect
  end
  
  def test_admin_access_to_other_show_page
    get :show, id: @user
    assert_response :success
  end
  

#
#  def test_new
#    get :new
#    assert_response :success
#  end
#
#  def test_index
#    get :index
#    assert_response :success
#  end

  def actions_that_should_be_blocked
    {
      index:    [:get,    {}], 
      edit:     [:get,    {id: @user.id}], 
      update:   [:put,    {id: @user.id, user: {email: new_email}}],
      new:      [:get,    {}],
      create:   [:post,   {id: @user.id, user: {email: new_email}}],
      destroy:  [:delete, {id: @user.id}]
    }
  end
  
  def assert_user_access_is_restricted
    actions_that_should_be_blocked.each do |action, options|
      assert_no_difference 'User.count', "#{action} should not change user count" do
        send(options[0], action, options[1])
        assert_response :redirect, "#{action} should be redirected"
        assert_not_equal(new_email, @user.reload.email, "#{action} should not lead to name change")
      end
    end
  end
  
  def new_email
    'someoneelse@example.com'
  end

end
