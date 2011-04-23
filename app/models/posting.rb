class Posting < ActiveRecord::Base
  belongs_to :user
  has_many :offers

  default_scope select('posting.*, user.login').includes(:user)
  scope :requests, where(:have_need => "need")
  scope :inventory, where(:have_need => "have")
end

