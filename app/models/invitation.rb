class Invitation < ActiveRecord::Base
  
  belongs_to :community
    
  validates_uniqueness_of :email, :scope => :community_id
  validates_format_of :email, :with => Authlogic::Regex.email
  
  default_scope includes(:community)
  
  def accept
    if membership = Membership.where(:user_id => current_user.id, :community_id => @invitation.community_id).first
      membership.update_attributes(:active => true, :accepted => true)
    else
      Membership.create(:user_id => current_user.id, :community_id => @invitation.community_id,
          :active => true, :accepted => true)
    end
    
    self.destroy
  end
  
end