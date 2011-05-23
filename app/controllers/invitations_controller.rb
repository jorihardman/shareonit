class InvitationsController < ApplicationController
  before_filter :require_user
  
  def new
    @community = Community.find(params[:community_id])
    puts controller_name
  
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def accept
    invitation = Invitation.find(params[:id])
    @membership = Membership.new(:user_id => current_user.id, :community_id => invitation.community_id, :active => true, :accepted => true)
    membership.save
    invitation.destroy
    
    respond_to do |format|
      format.js
      format.html { redirect_to communities_path, :notice => "#{membership.community.name} joined." }
    end
  end
  
  def destroy
    @invitation = Invitation.find(params[:id])
    
    respond_to do |format|
      format.js
    end  
  end
  
end
