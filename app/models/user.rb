class User < ActiveRecord::Base
  
  acts_as_authentic
	
  has_many :postings, :dependent => :destroy
	has_many :memberships, :dependent => :destroy
	has_many :communities, :through => :memberships
	has_many :managed_communities, :class_name => 'Community', :foreign_key => :user_id

  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation
  
  before_save :init
  after_create :welcome

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def active_communities
    communities.select('communities.id, communities.name').where('active = ?', true)
  end
  
  def accepted_communities
    communities.select('communities.id, communities.name').where('accepted = ?', true)
  end

  # workaround for mongomapper bug
  # http://bit.ly/bcQn3z
  def to_key
    [id.to_s]
  end
  
  private
  
  def init
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
  
  def welcome
    UserNotifier.delay.welcome(self)
  end
  
end