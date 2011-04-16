class Posting < ActiveRecord::Base

  def requests
    where(:posting_type => "need")
  end

  def possessions
    where(:posting_type => "have")
  end

end

