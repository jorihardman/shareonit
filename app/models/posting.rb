class Posting < ActiveRecord::Base
  
  has_attached_file :photo,
    :storage => :s3,
    :bucket => 'photos.shareon.it',
    :url => ':s3_alias_url',
    :s3_host_alias => 'photos.shareon.it',
    :path => '/postings/:id/:style.:extension',
    :default_url => '/images/default.png',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :styles => { 
      :thumb => ["100x100>"]
    }    
  process_in_background :photo
  
  belongs_to :user
  has_and_belongs_to_many :communities
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates :description, :presence => true, :length => {:within => 1..255}
  validates :price, :format => {:with => /^\d+??(?:\.\d{0,2})?$/}, :numericality => {:greater_than => 0}, :if => 'not free'
  
  default_scope select('postings.*, communities.name, users.first_name, users.last_name').
    includes(:user, :communities).
    where('postings.deleted = ?', false).
    order('postings.created_at DESC')
  
  def self.for_current_user
    where('communities.id IN (?)', UserSession.find.user.active_communities)
  end
  
  def self.categories
    ['Other', 'Books', 'Cleaning Supplies', 'Electronics', 'Food', 'Furniture', 'Games', 'Movies', 'Service']
  end
  
  def self.search_or_where(params, condition)
    search = params[:search]
    postings = Posting.for_current_user.where(condition)
    
    unless params[:category].blank?
      if params[:category] == 'Free'
        postings = postings.where('postings.free = ?', true)
      else
        postings = postings.where('postings.category = ?', params[:category])
      end
    end
    
    if search
      Search.create(:model => 'posting', :query => search)
      postings = postings.where("(users.first_name || ' ' || users.last_name) ILIKE ? OR postings.description ILIKE ?", 
        "%#{search}%", "%#{search}%")
    end
    
    return postings.paginate(:page => params[:page], :per_page => 10)
  end

  def add_to_inventory
    invPosting = self.clone
    invPosting.have = true
    invPosting.user_id = UserSession.find.user.id
    invPosting.save
    invPosting.add_to_active_communities
  end
  
  def add_to_active_communities
    UserSession.find.user.active_communities.each do |community|
      community.postings << self
    end
  end
  
end