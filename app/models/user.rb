class User < ActiveRecord::Base
	acts_as_authentic
	has_many :memberships
	has_many :communities, :through => :memberships
  has_many :received_reviews, :class_name => "Review", :foreign_key => :reviewee_id
  has_many :given_reviews, :class_name => "Review", :foreign_key => :reviewer_id
  has_many :sent_messages, :class_name => "Message", :foreign_key => :sender_id
  has_many :received_messages, :class_name => "Message", :foreign_key => :receiver_id
  has_many :postings

  # workaround for mongomapper bug
  # http://bit.ly/bcQn3z
  def to_key
    [id.to_s]
  end
end

