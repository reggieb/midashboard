class UserGroupUser < ActiveRecord::Base
  attr_accessible :user_group_id, :user_id
  
  belongs_to :user
  belongs_to :user_group
end
