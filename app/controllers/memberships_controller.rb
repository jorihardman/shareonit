class MembershipsController < ApplicationController
  
  before_filter :require_user
  before_filter :require_owner, :only => 'accept'
  
  def accept
    @membership = Membership.find(params[:id])
    @membership.accept
    
    respond_to do |format|
      format.html { redirect_to community_path(@membership.community_id),
          :notice => "#{@membership.user.full_name} accepted." }
      format.js
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    
    respond_to do |format|
      format.js
    end
  end
    
  def create
    @membership = Membership.new(:user_id => current_user.id, :community_id => params[:community_id])
    MembershipNotifier.delay.membership_request(@membership) if @membership.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def toggle
    @membership = Membership.find(params[:id])
    @membership.toggle
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def require_owner
    if current_user.id != Membership.find(params[:id]).community.user_id
      redirect_to communities_path, :notice => "That community doesn't belong to you."
      false
    end
  end
  
end