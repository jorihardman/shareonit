class Posting < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :communities
  
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
      :thumb => ["30x30#"] 
    }

  process_in_background :photo
  
  validates :description, :presence => true
  
  @@per_page = 10 #will_paginate

  default_scope select(
      'postings.*, communities.name, users.first_name, users.last_name'
    ).includes(
      :user, :communities
    ).where(
      'postings.deleted = ?', false
    )
    
  scope :for_current_user, lambda { 
    where('communities.id IN (?)', UserSession.find.user.active_communities)
  }  

  def for_current_user
    
  end

  def add_to_inventory
    invPosting = self.clone
    invPosting.have = true
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
    postings = Posting.for_current_user.where(condition)
    if search 
      postings = postings.where("(first_name || ' ' || last_name) ILIKE ? OR description ILIKE ?", 
        "%#{search}%", "%#{search}%")
    end
    return postings.paginate(:page => page)
  end
  
end
