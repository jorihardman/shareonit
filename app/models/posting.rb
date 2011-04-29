class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('posting.*, user.first_name, user.last_name').includes(:user)

  def self.add_to_inventory(offer)
    invPosting = offer.posting.clone
    invPosting.have_need = 'have'
    invPosting.user_id = offer.user_id
    invPosting.save
  end

  def self.search_or_where(search_params, condition)
    if search_params
      return @search.where(condition).search(search_params)
    else
      return Posting.where(condition)
    end
  end
end

