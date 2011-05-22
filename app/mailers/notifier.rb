class Notifier < ActionMailer::Base
  default :from => "ShareOnIt@shareon.it"

  def welcome()
    @user = UserSession.find.user
    mail(:subject => 'Welcome to Shareon.it', :to => user.email) do |format|
      format.html
    end
  end

  # To run this, create a cron job to run "rails runner Notifier.delay.daily_digest".
  def daily_digest
    @postings = Posting.where('postings.have_need = ? AND (postings.created_at > ? OR (postings.from_date > ? AND postings.from_date < ?))',
                              'need',
                              1.day.ago.strftime('%Y-%m-%d %H:%M:%S'),
                              Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                              1.day.from_now.strftime('%Y-%m-%d %H:%M:%S')
                              )

    mail(:subject => 'Your Shareon.it Friends Need You', :bcc => User.all.map(&:email)) do |format|
      format.html
    end
  end
  
  def offer(posting, message)
    @from_user = UserSession.find.user
    @to_user = posting.user
    @posting = posting
    @message = message
    subject = "#{@from_user.full_name} #{@posting.have_need == 'have' ? 'needs' : 'has'} #{@posting.description}"
    
    mail(:to => @to_user.email, :subject => subject, :reply_to => @from_user.email) do |format|
      format.html
    end
  end
  
  def feedback(feedback_message)
    @user = UserSession.find.user
    @message = feedback_message
    
    mail(:to => 'feedback@shareon.it', :subject => "Shareon.it Feedback") do |format|
      format.html
    end
  end
end

