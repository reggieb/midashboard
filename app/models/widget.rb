class Widget < ActiveRecord::Base
  attr_accessible :data_type, :description, :name, :root_uri, :title,
    :y_field, :y_label, :x_field, :x_label, :before_parameter, :after_parameter,
    :date_modifier, :x_times, :y_times, :x_points, :y_points, :chart_type,
    :y_compact_method, :x_compact_method

  DEFAULT_POINTS = 6
  DEFAULT_COMPACT_METHOD = 'first'
  DEFAULT_BEFORE_PARAMETER = 'before'
  DEFAULT_AFTER_PARAMETER = 'after'

  has_many :dashboard_widgets
  has_many :dashboards, through: :dashboard_widgets

  acts_as_indulgent

  validates :name, presence: true, uniqueness: true

  def raw
    @raw ||= ApiClient.new(uri).json
  end

  def uri
    @uri ||= URI(root_uri)
  end

  def before(time)
    add_to_query before_parameter => time_for_query(time)
  end

  def after(time)
    add_to_query after_parameter => time_for_query(time)
  end

  def time_for_query(time)
    date_modifier? ? time.strftime(date_modifier) : URI.escape(time.as_json)
  end

  def add_to_query(params)
    uri.query = (split_query + params.to_a).collect{|q| q.join('=')}.join('&')
  end

  def split_query
    unescaped_query.split('&').collect{|s| s.split('=')}
  end

  def unescaped_query
    uri.query ? URI.unescape(uri.query) : ""
  end

  def x_label
    first_or_human_second super, x_field
  end

  def y_label
    first_or_human_second super, y_field
  end

  def x_points
    super.blank? ? DEFAULT_POINTS : super
  end

  def y_points
    super.blank? ? DEFAULT_POINTS : super
  end

  def x_compact_method
    super.blank? ? DEFAULT_COMPACT_METHOD : super
  end

  def y_compact_method
    super.blank? ? DEFAULT_COMPACT_METHOD : super
  end

  def before_parameter
    super.blank? ? DEFAULT_BEFORE_PARAMETER : super
  end

  def after_parameter
    super.blank? ? DEFAULT_AFTER_PARAMETER : super
  end

  def title
    first_or_human_second super, name
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

  def first_or_human_second(first, second)
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
