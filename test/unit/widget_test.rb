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
  
  def test_uri
    assert_equal URI(@widget.root_uri), @widget.uri
  end
  
  def test_add_to_query
    @widget.add_to_query(this: 'that', foo: 'bar')
    assert_match /this=that&foo=bar/, @widget.uri.to_s
  end
  
  def test_spit_query
    @widget.uri.query = 'this=that%26foo%3dbar&something=else'
    expect = [['this','that'],['foo','bar'],['something','else']]
    assert_equal expect, @widget.split_query
  end
  
  def test_before
    time = Time.now
    @widget.before(time)
    assert_match "before=#{time.as_json}", @widget.uri.query
  end
  
  def test_after
    time = Time.now
    @widget.after(time)
    assert_match "after=#{time.as_json}", @widget.uri.query
  end
  
  def test_before_with_before_parameter
    time = Time.now
    @widget.before_parameter = 'earlier_than'
    @widget.before(time)
    assert_match "earlier_than=#{time.as_json}", @widget.uri.query
  end
  
  def test_after_with_after_parameter
    time = Time.now
    @widget.after_parameter = 'later_than'
    @widget.after(time)
    assert_match "later_than=#{time.as_json}", @widget.uri.query
  end
  
  def test_before_with_date_modifier
    time = Time.now
    mod = '%d-%b-%Y'
    @widget.date_modifier = mod
    @widget.before(time)
    assert_match "before=#{time.strftime(mod)}", @widget.uri.query
  end
  
  def test_after_with_date_modifier
    time = Time.now
    mod = '%d-%b-%Y'
    @widget.date_modifier = mod
    @widget.after(time)
    assert_match "after=#{time.strftime(mod)}", @widget.uri.query
  end

end
