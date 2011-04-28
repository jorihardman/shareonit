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

  # Returns postings. If there is a search, return search results.
  # Otherwise, return postings matching the condition.
  def self.search_or_where(condition,search_params)
    @search = Posting.search(search_params)
    if @search
      return @search.where(condition)
    else
      return Posting.where(condition)
    end
  end
end

