class Offer < ActiveRecord::Base
  belongs_to :posting
  belongs_to :user

  def receiver
    posting.user
  end
end

