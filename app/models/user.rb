class User < ActiveRecord::Base
	acts_as_authentic
	has_many :memberships
	has_many :communities, :through => :memberships
  has_many :postings

  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def active_communities
    #TODO
  end

  # workaround for mongomapper bug
  # http://bit.ly/bcQn3z
  def to_key
    [id.to_s]
  end
end

