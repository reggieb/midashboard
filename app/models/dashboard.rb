class Dashboard < ActiveRecord::Base
  attr_accessible :description, :name, :title, :widget_ids

  has_many :dashboard_widgets
  has_many :widgets, through: :dashboard_widgets

  accepts_nested_attributes_for :widgets
end
