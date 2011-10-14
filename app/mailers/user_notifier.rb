class UserNotifier < ActionMailer::Base

  default :from => "ShareOnIt@shareon.it"
  default_url_options[:host] = "shareon.it"

  def welcome(user)
    @user = user
    mail(:subject => 'Welcome to Shareon.it', :to => user.email) do |format|
      format.html
    end
  end
  
end