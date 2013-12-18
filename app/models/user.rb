class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id
  # attr_accessible :title, :body
  
  belongs_to :role
  has_many :user_group_users, uniq: true
  has_many :user_groups, through: :user_group_users
  
  has_many :dashboard_groups, as: :groupable, uniq: true
  has_many :dashboards, through: :dashboard_groups
end
