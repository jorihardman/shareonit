class MembershipsController < ApplicationController
  def accept
    @membership = Membership.find(params[:id])
    @membership.update_attributes(:accepted => true, :active => true)
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    postings = @membership.community.postings.where(:user_id => @membership.user_id)
    @membership.community.postings.delete(postings) if not postings.empty?
    @membership.destroy
    
    respond_to do |format|
      format.js
    end
  end
    
  def create
    @membership = Membership.new(:user_id => current_user.id, :community_id => params[:community_id])
    @membership.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @membership = Membership.find(params[:id])
    @membership.update_attribute(:active, !@membership.active)
    
    respond_to do |format|
      format.js
    end
  end
end
