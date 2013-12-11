class Widget < ActiveRecord::Base
  attr_accessible :data_type, :description, :name, :root_uri, :title,
    :y_field, :y_label, :x_field, :x_label, :before_parameter, :after_parameter,
    :date_modifier

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

  def title
    alternative_to_blank super, name
  end
  
  def labels
    [x_label, y_label]
  end

  def data_grid
    [data_x, data_y].transpose
  end

  def data_x
    @data_x ||= raw.collect{|h| process_cell(h[x_field])}
  end

  def data_y
    @data_y ||= raw.collect{|h| process_cell(h[y_field])}
  end

  def process_cell(entry)
    Time.parse(entry)
  rescue ArgumentError, TypeError
    entry
  end

  def labelled_data_grid
    [labels] + data_grid
  end

  def data
    data_grid
  end

  private
  def humanize(text)
    text.blank? ? "" : text.humanize
  end

  def alternative_to_blank(first, second)
    first.blank? ? humanize(second) : first
  end
end
