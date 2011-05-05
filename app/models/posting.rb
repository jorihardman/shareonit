class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('postings.*, users.first_name, users.last_name').includes(:user)

  validates :description, :presence => true

  def self.add_to_inventory(offer)
    invPosting = offer.posting.clone
    invPosting.have_need = 'have'
    invPosting.user_id = offer.user_id
    invPosting.save
  end

  def self.search_or_where(search, condition)
    if search
      return Posting.where(condition).where('CONCAT_WS(" ", first_name, last_name) LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
    else
      return Posting.where(condition)
    end
  end
end

