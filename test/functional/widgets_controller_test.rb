require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase
  setup do
    @widget = widgets(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:widgets)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Widget.count') do
      post :create, widget: { container: @widget.container, data_type: @widget.data_type, description: @widget.description, name: @widget.name, root_uri: @widget.root_uri, title: @widget.title }
    end

    assert_redirected_to widget_path(assigns(:widget))
  end

  def test_show
    get :show, id: @widget
    assert_response :success
  end

  def test_show_json
    enable_mock @widget.root_uri, things.to_json
    get :show, id: @widget, format: 'json'
    assert_response :success
    assert_equal stringify_keys(things), JSON.parse(response.body)
  end

  def test_edit
    get :edit, id: @widget
    assert_response :success
  end

  def test_update
    put :update, id: @widget, widget: { container: @widget.container, data_type: @widget.data_type, description: @widget.description, name: @widget.name, root_uri: @widget.root_uri, title: @widget.title }
    assert_redirected_to widget_path(assigns(:widget))
  end

  def test_destroy
    assert_difference('Widget.count', -1) do
      delete :destroy, id: @widget
    end

    assert_redirected_to widgets_path
  end
end
