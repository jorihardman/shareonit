class MembershipNotifier < ActionMailer::Base

  default :from => "ShareOnIt@shareon.it"
  default_url_options[:host] = "shareon.it"
  
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