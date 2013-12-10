require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  setup do
    @dashboard = dashboards(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboards)
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
