class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  
  default_scope select('memberships.*, users.first_name, users.last_name, users.email').includes(:user)
end

