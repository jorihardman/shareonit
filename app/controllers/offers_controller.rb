class OffersController < ApplicationController
  before_filter :require_user

  def new
    @offer = Offer.new

    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  def create
    @offer = Offer.new(params[:offer])

    # If add_to_inventory is checked, then it's in the hash, otherwise it
    # doesn't exist in the hash, so || 0.
    addToInventory = params[:add_to_inventory] || 0
    
    if addToInventory
      invPosting = @offer.posting.clone #Posting.new(@offer.posting)
      invPosting.have_need = 'have'
      invPosting.user_id = @offer.user_id
    
      # See if this posting is already in Postings.
      copyInvPosting = Posting.where( :user_id => invPosting.user_id, :description => invPosting.description ).first
      invPosting.save unless copyInvPosting
    end
    
    respond_to do |format|
      if @offer.save
        @notice = 'Offer successfully made.'
        format.js
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        @notice = 'Error posting offer.'
        format.js
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def accept
    Posting.find(params[:posting_id]).update_attribute(:status, 'successful')
    @offers = Offer.where(:posting_id => params[:posting_id])
    @offers.each do |offer|
      offer.update_attribute(:status, offer.id == params[:id].to_i ? 'accepted' : 'declinded')
    end

    respond_to do |format|
      format.js
      format.xml { render :status => :ok }
    end
  end

  def delete
  end

  def update
  end
end

