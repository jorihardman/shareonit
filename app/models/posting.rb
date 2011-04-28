class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('posting.*, user.full_name').includes(:user)

  def self.add_to_inventory(offer)
    invPosting = offer.posting.clone
    invPosting.have_need = 'have'
    invPosting.user_id = offer.user_id
    invPosting.save
  end
end

