class Notifier < ActionMailer::Base
  default :from => "uswap@uswap.it"
  
  def welcome(user)
    @user = user
    mail( :subject => 'Welcome to Uswap.it', :to => user.email ) do |format|
      format.html
    end
  end
  
  # To run this, create a cron job to run "rails runner Notifier.daily_digest.deliver".
  def daily_digest
    current_time = Time.now
    one_day_future = current_time + 24*3600
    one_day_past = current_time - 24*3600
    
    # Get postings which were created in the last 24 hours, or postings that need
    # to be filled starting in the next 24 hours.
    @postings = Posting.where('postings.have_need = ? AND ( postings.created_at > ? OR ( postings.from_date > ? AND postings.from_date < ? ) )',
                              'need',
                              one_day_past.strftime('%Y-%m-%d %H:%M:%S'),
                              current_time.strftime('%Y-%m-%d %H:%M:%S'),
                              one_day_future.strftime('%Y-%m-%d %H:%M:%S')
                              )
    
    mail( :subject => 'Your Uswap.it Friends Need You', :bcc => User.all.map(&:email) ) do |format|
      format.html
    end
  end
end
