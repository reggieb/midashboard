class DashboardWidget < ActiveRecord::Base
  attr_accessible :dashboard_id, :widget_id

  belongs_to :dashboard
  belongs_to :widget
end
