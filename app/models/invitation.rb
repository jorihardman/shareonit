class Invitation < ActiveRecord::Base
  belongs_to :community
  
  default_scope includes(:community)
  
  validates_uniqueness_of :email, :scope => [:community_id]
end
