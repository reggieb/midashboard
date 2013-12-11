require 'test_helper'

class WidgetTest < ActiveSupport::TestCase

  def setup
    @widget = widgets :one
    enable_mock @widget.root_uri, things.to_json
  end

  def test_raw
    assert_equal stringify_keys(things), @widget.raw
  end

  def test_x_label
    label = "This label"
    field = "a_field"
    @widget.x_label = label
    @widget.x_field = field
    assert_equal label, @widget.x_label
    @widget.x_label = ""
    assert_equal field.humanize, @widget.x_label
    @widget.x_field = nil
    assert_equal "", @widget.x_label
  end

  def test_y_label
    label = "This label"
    field = "a_field"
    @widget.y_label = label
    @widget.y_field = field
    assert_equal label, @widget.y_label
    @widget.y_label = ""
    assert_equal field.humanize, @widget.y_label
    @widget.y_field = nil
    assert_equal "", @widget.y_label
  end

  def test_title_blank
    @widget.title = ""
    assert_equal @widget.name.humanize, @widget.title
  end

end
