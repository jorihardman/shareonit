class Offer < ActiveRecord::Base
  belongs_to :posting
  belongs_to :user

  validates :message, :presence => true

  default_scope select('offer.*, user.full_name').includes(:user)
end

