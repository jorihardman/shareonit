class Posting < ActiveRecord::Base
  belongs_to :user

  def requests
    where(:posting_type => "need")
  end

  def possessions
    where(:posting_type => "have")
  end

end

