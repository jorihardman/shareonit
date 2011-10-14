class PostingNotifier < ActionMailer::Base

  default :from => "ShareOnIt@shareon.it"
  default_url_options[:host] = "shareon.it"

  def daily_digest(user)
    @postings = Posting.for_user(user).where('postings.created_at > ?', 1.day.ago)
  
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
  
end