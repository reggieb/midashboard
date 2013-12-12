require 'test_helper'

class DataSeriesTest < ActiveSupport::TestCase

  def setup
    @data = [2, 3, 5, 19.5]
    @data_series = DataSeries.new(@data)
  end

  def test_max
    assert_equal @data.max, @data_series.max
  end

  def test_min
    assert_equal @data.min, @data_series.min
  end
  
  def test_percentage_factor
    expected = 100.0 / @data.max.ceil
    assert_equal expected, @data_series.percentage_factor
  end
  
  def test_percentages
    factor = 100.0 / @data.max.ceil
    expected = @data.collect{|d| d * factor}
    assert_equal expected, @data_series.percentages
  end
  
  def test_labels
    expected = [0, 4, 8, 12, 16, 20]
    assert_equal expected, @data_series.labels
  end
  
  def test_labels_with_number
    expected = [0, 5, 10, 15, 20]
    assert_equal expected, @data_series.labels(expected.length)
  end
  
  def test_labels_with_proc
    expected = ['0', '4', '8', '12', '16', '20']
    assert_equal expected, @data_series.labels{|l| l.to_i.to_s}
  end
  
  def test_labels_with_float_issue
    data_series = DataSeries.new([1])
    expected = %w{0.0 0.2 0.4 0.6 0.8 1.0}
    assert_equal expected, data_series.labels{|l| l.to_s}
  end
  
  def test_tight_percentages
    @data_series = DataSeries.new(@data, tight: true)
    offset = @data.min.floor
    factor = 100.0 / (@data.max.ceil - offset)   
    expected = @data.collect{|d| (d - offset) * factor }
    assert_equal expected, @data_series.percentages 
  end
  
  def test_tight_labels
    @data_series = DataSeries.new([10, 15, 20], tight: true)
    expected = [10, 12, 14, 16, 18, 20]
    assert_equal expected, @data_series.labels
  end
 

end
