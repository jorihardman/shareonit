class Community < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  belongs_to :user
  has_and_belongs_to_many :postings
  
  def send_invitations(email_list)
    email_list.strip.split(',').each do |email|
      user = User.find_by_email(email)
      membership = Membership.find_by_user_id(user.id) if user
      invitation = Invitation.new(:email => email, :community_id => self.id)
      
      if membership.nil? and invitation.save
        Notifier.send_invitation(invitation)
      end
    end
  end
end

