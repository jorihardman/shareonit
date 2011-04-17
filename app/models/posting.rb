class Posting < ActiveRecord::Base
  belongs_to :user

  scope :requests, where({:posting_type => "have"})
  scope :inventory, where({:posting_type => "want"})

end

