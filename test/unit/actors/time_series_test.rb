require 'test_helper'

class TimeSeriesTest < ActiveSupport::TestCase
  
  def setup
    @data = [10, 8, 2, 0].collect{|n| n.days.ago}
    @time_series = TimeSeries.new(@data)
  end
  
  def test_max
    assert_equal @data.last.to_f, @time_series.max
  end
  
  def test_min
    assert_equal @data.first.to_f, @time_series.min
  end
  
  def test_percentage_factor
    offset = @data.min.to_f.floor
    expected = 100.0 / (@data.last.to_f.ceil - offset)
    assert_equal expected, @time_series.percentage_factor
  end
  
  def test_percentages
    offset = @data.min.to_f.floor
    factor = 100.0 / (@data.last.to_f.ceil - offset)
    expected = @data.collect{|d| (d.to_f - offset) * factor}
    assert_equal expected, @time_series.percentages
  end
  
  def test_labels
    mod = "%d-%m-%Y %H:%M"
    expected = [10, 8, 6, 4, 2, 0].collect{|n| n.days.ago.strftime(mod)}
    assert_equal expected, @time_series.labels.collect{|l| l.strftime(mod)}
  end
  
  def test_labels_with_number
    mod = "%d-%m-%Y %H:%M"
    expected = [10, 5, 0].collect{|n| n.days.ago.strftime(mod)}
    assert_equal expected, @time_series.labels(expected.length).collect{|l| l.strftime(mod)}
  end
  
  def test_labels_with_proc
    mod = "%d-%m-%Y"
    expected = [10, 8, 6, 4, 2, 0].collect{|n| n.days.ago.strftime(mod)}
    assert_equal expected, @time_series.labels{|l| l.strftime(mod)}
  end
  
end
