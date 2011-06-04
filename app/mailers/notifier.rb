class Notifier < ActionMailer::Base

  default :from => "ShareOnIt@shareon.it"
  default_url_options[:host] = "shareon.it"

  def welcome(user)
    @user = user
    mail(:subject => 'Welcome to Shareon.it', :to => user.email) do |format|
      format.html
    end
  end

  # To run this, create a cron job to run "rails runner Notifier.delay.daily_digest".
  def daily_digest
    @postings = Posting.where('postings.have = ? AND (postings.created_at > ? OR (postings.from_date > ? AND postings.from_date < ?))',
                              false,
                              1.day.ago.strftime('%Y-%m-%d %H:%M:%S'),
                              Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                              1.day.from_now.strftime('%Y-%m-%d %H:%M:%S')
                              )

    mail(:subject => 'Your Shareon.it Friends Need You', :bcc => User.all.map(&:email)) do |format|
      format.html
    end
  end
  
  def offer(posting, message, user)
    @from_user = user
    @to_user = posting.user
    @posting = posting
    @message = message
    subject = "#{@from_user.full_name} #{@posting.have ? 'needs' : 'has'} #{@posting.description}"
    
    mail(:to => @to_user.email, :subject => subject, :reply_to => @from_user.email) do |format|
      format.html
    end
  end
  
  def feedback(feedback_message, user)
    @user = user
    @message = feedback_message
    
    mail(:to => 'feedback@shareon.it', :subject => "Shareon.it Feedback") do |format|
      format.html
    end
  end
  
  def invitation(invitation)
    @invitation = invitation
    @recipient = User.where(:email => @invitation.email).first
    
    mail(:to => @invitation.email, :subject => "You've been invited to a Shareon.it community") do |format|
      format.html
    end
  end

  def request_accepted(membership)
    @membership = membership
    
    mail(:to => @membership.user.email, :subject => "Your Shareon.it request was accepted") do |format|
      format.html
    end
  end
  
  def membership_request(membership)
    @membership = membership
    
    mail(:to => @membership.community.user.email, 
         :subject => "#{@membership.user.full_name} wants to join #{@membership.community.name}") do |format|
      format.html
    end
  end

end
