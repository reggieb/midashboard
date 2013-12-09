class Widget < ActiveRecord::Base
  attr_accessible :container, :data_type, :description, :name, :root_uri, :title

  has_many :dashboard_widgets
  has_many :dashboards, through: :dashboard_widgets

  def data
    ApiClient.new(root_uri).json
  end
end
