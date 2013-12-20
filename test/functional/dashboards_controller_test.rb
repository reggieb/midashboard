require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  def setup
    @dashboard = dashboards(:one)
    @user = users(:user)
    sign_in @user
  end

  def test_index
    get :index
    assert_response :success
  end
  
  def test_index_links
    test_index_dashboards_when_user_has_a_dashboard
    assert_no_tag :a, attributes: {href: new_dashboard_path}
    assert_tag :a, attributes: {href: dashboard_path(@dashboard)}
    assert_no_tag :a, attributes: {href: edit_dashboard_path(@dashboard)}
    assert_no_tag :a, attributes: {href: dashboard_path(@dashboard), 'data-method' => 'delete'}    
  end
  
  def test_index_links_for_admin
    sign_in users(:admin)
    get :index
    assert_tag :a, attributes: {href: new_dashboard_path}
    assert_tag :a, attributes: {href: dashboard_path(@dashboard)}
    assert_tag :a, attributes: {href: edit_dashboard_path(@dashboard)}
    assert_tag :a, attributes: {href: dashboard_path(@dashboard), 'data-method' => 'delete'}
  end
  
  def test_index_dashboards
    get :index
    assert_equal [], @user.all_dashboards
    assert_equal @user.all_dashboards, assigns(:dashboards)
  end
  
  def test_index_dashboards_when_user_has_a_dashboard
    @user.dashboards << @dashboard
    get :index
    assert_equal @user.all_dashboards, assigns(:dashboards)
  end
  
  def test_index_dashboards_for_admin
    sign_in users(:admin)
    get :index
    assert_equal Dashboard.all, assigns(:dashboards)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Dashboard.count') do
      post :create, dashboard: { 
        description: @dashboard.description,
        name: @dashboard.name,
        title: @dashboard.title
      }
    end

    assert_redirected_to dashboard_path(assigns(:dashboard))
  end

  def test_show
    enable_mock @dashboard.widgets.first.root_uri, things.to_json
    get :show, id: @dashboard
    assert_response :success
  end

  def test_get
    get :edit, id: @dashboard
    assert_response :success
  end

  def test_update
    put :update, id: @dashboard, dashboard: { 
      description: @dashboard.description,
      name: @dashboard.name,
      title: @dashboard.title
    }
    assert_redirected_to dashboard_path(assigns(:dashboard))
  end

  def test_update_add_widget
    put :update, id: @dashboard, dashboard: {
      description: @dashboard.description,
      name: @dashboard.name,
      title: @dashboard.title,
      widget_ids: [widget.id.to_s]
    }
    assert_redirected_to dashboard_path(assigns(:dashboard))
    assert_equal [widget], @dashboard.reload.widgets
  end

  def test_update_remove_widget
    test_update_add_widget
    put :update, id: @dashboard, dashboard: {
      description: @dashboard.description,
      name: @dashboard.name,
      title: @dashboard.title,
      widget_ids: []
    }
    assert_redirected_to dashboard_path(assigns(:dashboard))
    assert_equal [], @dashboard.reload.widgets
  end

  def test_update_remove_widget_by_not_sending_widget_ids
    test_update_add_widget
    put :update, id: @dashboard, dashboard: {
      description: @dashboard.description,
      name: @dashboard.name,
      title: @dashboard.title
    }
    assert_redirected_to dashboard_path(assigns(:dashboard))
    assert_equal [], @dashboard.reload.widgets
  end

  def test_destroy
    assert_difference('Dashboard.count', -1) do
      delete :destroy, id: @dashboard
    end

    assert_redirected_to dashboards_path
  end

  def widget
    @widget ||= widgets(:one)
  end
end
