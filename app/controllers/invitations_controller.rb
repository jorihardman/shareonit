class InvitationsController < ApplicationController
  
  before_filter :require_user
  before_filter :require_owner, :only => 'accept'
  
  def new
    @community = Community.find(params[:community_id])
  
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def create
    @community = Community.find(params[:community_id])
    @community.send_invitations(params[:emails])
    
    respond_to do |format|
      format.js
    end
  end
  
  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.accept
    
    respond_to do |format|
      format.js
      format.html { redirect_to root_path, :notice => "#{@invitation.community.name} joined." }
    end
  end
  
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    
    respond_to do |format|
      format.js
    end  
  end
  
  private
  
  def require_owner
    if current_user.email != Invitation.find(params[:id]).email
      redirect_to communities_path, :notice => 'That invitation doesn\'t belong to you.'
      false
    end
  end
  
end