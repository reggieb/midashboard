require 'test_helper'

class WidgetTest < ActiveSupport::TestCase

  def setup
    @widget = widgets :one
    enable_mock @widget.root_uri, things.to_json
  end

  def test_data
    assert_equal stringify_keys(things), @widget.data
  end
end
