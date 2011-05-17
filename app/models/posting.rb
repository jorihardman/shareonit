class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('postings.*, users.first_name, users.last_name').includes(:user)

  validates :description, :presence => true

  def add_to_inventory(user)
    invPosting = self.clone
    invPosting.have_need = 'have'
    invPosting.user_id = user.id
    invPosting.save
  end

  def self.search_or_where(search, condition, page)
    if search
      return Posting.where(condition).where(
        '(users.first_name ILIKE ? OR users.last_name ILIKE ? OR description ILIKE ?) AND deleted = ?', 
        "%#{search}%", "%#{search}%", "%#{search}%", false
      ).order('postings.created_at DESC').paginate(:page => page, :per_page => 15)
    else
      return Posting.where(condition).where(:deleted => false).order('postings.created_at DESC').paginate(:page => page, :per_page => 15)
    end
  end
end

