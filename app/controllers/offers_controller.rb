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
    if @offer.receiver == current_user.id
      @offers = Offer.where({:posting_id => @offer.posting_id})
    else
      @offers = Offer.where({:posting_id => @offer.posting_id, :user_id => current_user.id})
    end

    respond_to do |format|
      if @offer.save
        @notice = 'Offer successfully made.'
        format.js
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        @notice = 'Error making offer.'
        format.js
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def delete
  end

  def update
  end
end

