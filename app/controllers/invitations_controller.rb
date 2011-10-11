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
    @invitation.destroy
    membership = Membership.where(:user_id => current_user.id, :community_id => @invitation.community_id).first
    if membership.nil?
      membership = Membership.new(:user_id => current_user.id, :community_id => @invitation.community_id,
          :active => true, :accepted => true)
      membership.save
    else
      membership.update_attributes(:active => true, :accepted => true)
    end
    
    respond_to do |format|
      format.js
      format.html { redirect_to root_path, :notice => "#{membership.community.name} joined." }
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
      return false
    end
  end
  
end