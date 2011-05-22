class Posting < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :communities
  @@per_page = 10

  default_scope select(
                  'postings.*, communities.name, users.first_name, users.last_name'
                ).includes(
                  :user, :communities
                ).where(
                  'deleted = ? AND community_id IN (?)', false, UserSession.find.user.active_communities.map{ |it| it.community_id }
                ).order('postings.created_at DESC')

  validates :description, :presence => true

  def add_to_inventory
    invPosting = self.clone
    invPosting.have_need = 'have'
    invPosting.user_id = UserSession.find.user_id
    invPosting.save
    invPosting.add_to_active_communities
  end
  
  def add_to_active_communities
    UserSession.find.user.active_communities.each do |community|
      community.postings << self
    end
  end

  def self.search_or_where(search, condition, page)
    if search
      return Posting.where(condition).where(
        "(first_name || ' ' || last_name) ILIKE ? OR description ILIKE ?", 
        "%#{search}%", "%#{search}%"
      ).paginate(:page => page)
    else
      return Posting.where(condition).paginate(:page => page)
    end
  end
end

