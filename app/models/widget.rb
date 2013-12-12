class Widget < ActiveRecord::Base
  attr_accessible :data_type, :description, :name, :root_uri, :title,
    :y_field, :y_label, :x_field, :x_label, :before_parameter, :after_parameter,
    :date_modifier, :x_times, :y_times, :x_points, :y_points, :chart_type
  
  DEFAULT_POINTS = 6

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

  def title
    alternative_to_blank super, name
  end
  
  def x_data
    @x_data ||= raw.collect{|h| process_cell(h[x_field], x_times?)}
  end

  def y_data
    @y_data ||= raw.collect{|h| process_cell(h[y_field], y_times?)}
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
    [x_data, y_data].transpose
  end

  private
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
end
