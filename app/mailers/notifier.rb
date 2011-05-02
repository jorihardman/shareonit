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
    @postings = Posting.where('postings.have_need = ? AND (postings.created_at > ? OR (postings.from_date > ? AND postings.from_date < ?))',
                              'need',
                              1.day.ago.strftime('%Y-%m-%d %H:%M:%S'),
                              Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                              1.day.from_now.strftime('%Y-%m-%d %H:%M:%S')
                              )

    mail( :subject => 'Your Uswap.it Friends Need You', :bcc => User.all.map(&:email) ) do |format|
      format.html
    end
  end
end

