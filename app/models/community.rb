class Community < ActiveRecord::Base
  
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  belongs_to :user
  has_and_belongs_to_many :postings
    
  validates :zip_code, :presence => true, :numericality => true
  validates :name, :presence => true, :uniqueness => true
  
  after_create :create_user_membership
  
  def self.search(search, page)
    communities = Community.where('communities.id != ?', 0) #start with all records
    joined_communities = UserSession.find.user.communities.select('communities.id')
    communities = Community.where('communities.id NOT IN (?)', joined_communities) unless joined_communities.blank?
   
    if search
      Search.create(:model => 'community', :query => search)
      if search =~ /^\d+$/ #if search is a number
        communities = communities.where('communities.zip_code = ?', search.to_i)
      else
        communities = communities.where('communities.name ILIKE ?', "%#{search}%")
      end
    end
    
    return communities.paginate(:page => page, :per_page => 10)
  end
  
  def send_invitations(email_list)
    email_list.strip.split(',').each do |email|
      user = User.find_by_email(email.strip!)
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
  
end