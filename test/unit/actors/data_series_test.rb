require 'test_helper'

class DataSeriesTest < ActiveSupport::TestCase

  def setup
    @widget = widgets(:one)
    enable_mock @widget.root_uri, things.to_json
    @data_series = DataSeries.new(@widget.data_grid)
  end

  def test_x_max
    assert_equal @widget.data_x.max, @data_series.x_max
  end

  def test_y_max
    assert_equal @widget.data_y.max, @data_series.y_max
  end

  def test_x_min
    assert_equal @widget.data_x.min, @data_series.x_min
  end

  def test_y_min
    assert_equal @widget.data_y.min, @data_series.y_min
  end

end
