class DashboardGroup < ActiveRecord::Base
  attr_accessible :dashboard_id, :groupable_id, :groupable_type, :name
  
  belongs_to :groupable, polymorphic: true
  belongs_to :dashboard
end
