class Invitation < ActiveRecord::Base
  
  belongs_to :community
    
  validates_uniqueness_of :email, :scope => :community_id
  validates_format_of :email, :with => Authlogic::Regex.email
  
  default_scope includes(:community)
  
end
