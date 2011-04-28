class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('posting.*, user.full_name').includes(:user)
end

