class MembershipsController < ApplicationController
  def new
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def create
    respond_to do |format|
      format.js
    end
  end

  def accept
    @membership = Membership.find(params[:id])
    @membership.update_attributes(:accepted => true, :active => true)
    
    respond_to do |format|
      format.js
    end
  end
#  
#  def destroy
#    @membership = Membership.new(params[:id])
#    @membership.destroy
#    
#    respond_to do |format|
#      format.js
#    end
#  end
#  
#  def request
#    Membership.new(:user_id => current_user.id, :community_id => params[:community_id]).save
#    
#    respond_to do |format|
#      format.js
#    end
#  end
end
