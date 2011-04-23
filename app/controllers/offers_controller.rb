class OffersController < ApplicationController
  before_filter :require_user

  def new
    @offer = Offer.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @offer = Offer.new(params[:offer])

    @offers = []
    if @offer.posting.user_id == current_user.id
      @offers = Offer.where(:posting_id => @offer.posting_id)
    else
      @offers = Offer.where(:posting_id => @offer.posting_id, :user_id => current_user.id)
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

