class User < ActiveRecord::Base
	acts_as_authentic
	has_many :memberships
	has_many :communities, :through => :memberships
  has_many :received_reviews, :class_name => "Review", :foreign_key => :reviewee_id
  has_many :given_reviews, :class_name => "Review", :foreign_key => :reviewer_id
  has_many :postings
  has_many :received_offers, :through => :postings, :source => :offers
  has_many :offers

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  # workaround for mongomapper bug
  # http://bit.ly/bcQn3z
  def to_key
    [id.to_s]
  end
end

