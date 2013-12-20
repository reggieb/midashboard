class Dashboard < ActiveRecord::Base
  attr_accessible :description, :name, :title, :widget_ids

  has_many :dashboard_widgets, dependent: :destroy, uniq: true
  has_many :widgets, through: :dashboard_widgets, dependent: :destroy, uniq: true
  accepts_nested_attributes_for :widgets, allow_destroy: true
  
  has_many :dashboard_groups, uniq: true
  
  acts_as_indulgent
  
  validates :name, presence: true, uniqueness: true
  
end
