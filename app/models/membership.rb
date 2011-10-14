class Membership < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :community
    
  validates_uniqueness_of :user_id, :scope => :community_id
  
  before_destroy :delete_postings
  
  default_scope select('memberships.*, users.first_name, users.last_name, users.email').includes(:user)
  
  def delete_postings
    postings = community.postings.where(:user_id => user_id)
    community.postings.delete(postings) unless postings.blank?
  end
  
end