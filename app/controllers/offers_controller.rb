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

    respond_to do |format|
      if @offer.save
        Posting.add_to_inventory(@offer) if params[:add_to_inventory]
        @notice = 'Offer successfully made.'
        format.js
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
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

  def edit
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        @notice = 'Update successful.'
        format.js
      else
        format.js
      end
    end
  end

  def destroy
  end
end

