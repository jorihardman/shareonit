class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  
  default_scope select('memberships.*, users.first_name, users.last_name, users.email').includes(:user)
  
  validates_uniqueness_of :user_id, :scope => [:community_id]
  
  before_destroy :delete_postings
  
  def delete_postings
    postings = community.postings.where(:user_id => user_id)
    community.postings.delete(postings) if not postings.empty?
  end
end

