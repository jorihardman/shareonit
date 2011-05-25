class Community < ActiveRecord::Base

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  belongs_to :user
  has_and_belongs_to_many :postings
  
  validates :zip_code, :presence => true, :numericality => true
  validates :name, :presence => true, :uniqueness => true
  
  after_save :create_user_membership
  
  @@per_page = 10
  
  def send_invitations(email_list)
    email_list.strip.split(',').each do |email|
      email.strip!
      user = User.find_by_email(email)
      membership = Membership.find_by_user_id_and_community_id(user.id, self.id) if user
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
    joined_communities = UserSession.find.user.communities.select('communities.id')
    communities = []
    unless joined_communities.empty?
      communities = Community.where('id NOT IN (?)', joined_communities)
    else
      communities = Community.all
    end
    communities = communities.where('name ILIKE ?', "%#{search}%") if search
    communities.paginate(:page => page)
  end
  
end

