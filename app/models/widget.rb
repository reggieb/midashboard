class Widget < ActiveRecord::Base
  attr_accessible :data_type, :description, :name, :root_uri, :title,
    :y_field, :y_label, :x_field, :x_label, :before_parameter, :after_parameter,
    :date_modifier

  has_many :dashboard_widgets
  has_many :dashboards, through: :dashboard_widgets

  def data
    ApiClient.new(root_uri).json
  end
end
