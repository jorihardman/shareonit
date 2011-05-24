class Community < ActiveRecord::Base

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  belongs_to :user
  has_and_belongs_to_many :postings
  
  after_save :create_user_membership
  
  @@per_page = 10
  
  def send_invitations(email_list)
    email_list.strip.split(',').each do |email|
      user = User.find_by_email(email)
      membership = Membership.find_by_user_id(user.id) if user
      invitation = Invitation.new(:email => email, :community_id => self.id)
      
      if membership.nil?
        Notifier.delay.invitation(invitation) if invitation.save
      end
    end
  end
  
  def create_user_membership
    Membership.new(:user_id => UserSession.find.user.id, :community_id => id, :active => true, :accepted => true).save  
  end
  
  def self.search(search, page)
    communities = Community.where('id NOT IN (?)', UserSession.find.user.communities.select('communities.id'))
    communities = communities.where('name ILIKE ?', "%#{search}%") if search
    communities.paginate(:page => page)
  end
  
end

