require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase
  def setup
    @widget = widgets(:one)
    sign_in users(:user)
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
      post :create, widget: {
        data_type: @widget.data_type,
        description: @widget.description,
        name: 'new_name',
        root_uri: @widget.root_uri,
        title: @widget.title,
        x_field: @widget.x_field,
        y_field: @widget.y_field
      }
    end

    assert_redirected_to widget_path(assigns(:widget))
  end

  def test_show
    enable_mock @widget.root_uri, things.to_json
    get :show, id: @widget
    assert_response :success
  end

  def test_show_json
    enable_mock @widget.root_uri, things.to_json
    get :show, id: @widget, format: 'json'
    assert_response :success
    assert_equal @widget.data.to_json, response.body
  end

  def test_edit
    get :edit, id: @widget
    assert_response :success
  end

  def test_update
    text = 'New Title'
    put :update, id: @widget, widget: {
      title: text
    }
    assert_redirected_to widget_path(assigns(:widget))
    assert_equal text, assigns(:widget).title
  end

  def test_destroy
    assert_difference('Widget.count', -1) do
      delete :destroy, id: @widget
    end

    assert_redirected_to widgets_path
  end
end
