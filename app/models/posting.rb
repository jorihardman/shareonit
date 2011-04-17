class Posting < ActiveRecord::Base
  belongs_to :user

  scope :requests, where({:have_need => "need"})
  scope :inventory, where({:have_need => "have"})

end

