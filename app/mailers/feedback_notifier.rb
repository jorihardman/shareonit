class FeedbackNotifier < ActionMailer::Base

  default :from => "ShareOnIt@shareon.it"
  default_url_options[:host] = "shareon.it"

  def feedback(feedback_message, user)
    @user = user
    @message = feedback_message
  
    mail(:to => 'feedback@shareon.it', :subject => "Shareon.it Feedback") do |format|
      format.html
    end
  end
  
end