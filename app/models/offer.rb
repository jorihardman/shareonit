class Offer < ActiveRecord::Base
  belongs_to :posting
  belongs_to :user

  default_scope select('offer.*, user.login').includes(:user)
end

