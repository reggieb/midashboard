class UserGroup < ActiveRecord::Base
  attr_accessible :name
  
  has_many :dashboard_groups, as: :groupable, uniq: true
  has_many :dashboards, through: :dashboard_groups
  
  has_many :user_group_users, uniq: true
  has_many :users, through: :user_group_users
end
