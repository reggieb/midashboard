class Widget < ActiveRecord::Base
  attr_accessible :data_type, :description, :name, :root_uri, :title,
    :y_field, :y_label, :x_field, :x_label, :before_parameter, :after_parameter,
    :date_modifier, :x_times, :y_times, :x_points, :y_points, :chart_type,
    :y_compact_method, :x_compact_method
  
  DEFAULT_POINTS = 6
  DEFAULT_COMPACT_METHOD = 'first'

  has_many :dashboard_widgets
  has_many :dashboards, through: :dashboard_widgets

  def raw
    @raw ||= ApiClient.new(root_uri).json
  end

  def x_label
    alternative_to_blank super, x_field
  end

  def y_label
    alternative_to_blank super, y_field
  end
  
  def x_points
    alternative_to_blank super, DEFAULT_POINTS
  end
  
  def y_points
    alternative_to_blank super, DEFAULT_POINTS
  end

  def x_compact_method
    alternative_to_blank super, DEFAULT_COMPACT_METHOD
  end

  def y_compact_method
    alternative_to_blank super, DEFAULT_COMPACT_METHOD
  end

  def title
    alternative_to_blank super, name
  end
  
  def x_data
    @x_data ||= get_data_for(x_field, x_times?)
  end

  def y_data
    @y_data ||= get_data_for(y_field, y_times?)
  end
  
  def x_series
    @x_series ||= x_series_class.new(x_data)
  end
  
  def y_series
    @y_series ||= y_series_class.new(y_data)
  end

  def process_cell(entry, times)
    return parse_time(entry) if times
    return entry.to_f if numeric?(entry)
    entry
  end
  
  def numeric?(entry)
    return true if entry =~ /^\d+$/
    true if Float(entry) rescue false
  end
  
  def parse_time(entry)
    Time.parse(entry)
  rescue ArgumentError, TypeError
    entry
  end
  
  def data
    @data ||= build_data
  end

  private
  def build_data
    x_data.compact_to! y_data, x_compact_method
    y_data.compact_to! x_data, y_compact_method
    [x_data, y_data].transpose
  end

  def humanize(text)
    text.blank? ? "" : text.humanize
  end

  def alternative_to_blank(first, second)
    first.blank? ? humanize(second) : first
  end
  
  def y_series_class
    y_times? ? TimeSeries : DataSeries
  end
  
  def x_series_class
    x_times? ? TimeSeries : DataSeries
  end

  def walkable_hash
    @walkable_hash ||= HashWalker.new(raw)
  end

  def get_data_for(field, is_time)
    Compactor.new walkable_hash.array(field).collect{|d| process_cell(d, is_time)}
  end
end
