class Community < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  belongs_to :user
  has_and_belongs_to_many :postings
end

