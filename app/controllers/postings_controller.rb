class PostingsController < ApplicationController
  before_filter :require_user

  def index
    respond_to do |format|
      format.html { redirect_to :action => 'products_requests' }
      format.js
    end
  end

  def my_inventory
    @postings = Posting.search_or_where(params[:search], {:have_need => 'have', :user_id => current_user.id})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def my_requests
    @postings = Posting.search_or_where(params[:search], {:have_need => 'need', :user_id => current_user.id})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def services_inventory
    store_location
    @postings = Posting.search_or_where(params[:search], {:have_need => 'have', :product_service => 'service'})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def services_requests
    store_location
    @postings = Posting.search_or_where(params[:search], {:have_need => 'need', :product_service => 'service'})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def products_inventory
    store_location
    @postings = Posting.search_or_where(params[:search], {:have_need => 'have', :product_service => 'product'})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def products_requests
    store_location
    @postings = Posting.search_or_where(params[:search], {:have_need => 'need', :product_service => 'product'})

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def show
    @posting = Posting.find(params[:id])

    respond_to do |format|
      format.js
      format.html
      format.xml  { render :xml => @posting }
    end
  end

  def new
    @posting = Posting.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @posting }
      format.js
    end
  end

  def edit
    @posting = Posting.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @posting = Posting.new(params[:posting])
    unless params[:posting][:to_date].blank? and params[:posting][:from_date].blank?
      @posting.from_date = Date.strptime(params[:posting][:from_date], "%m/%d/%Y")
      @posting.to_date = Date.strptime(params[:posting][:to_date], "%m/%d/%Y")
    end

    respond_to do |format|
      if @posting.save
        @notice = 'Posting successful.'
        format.js
        format.xml  { render :xml => @posting, :status => :created, :location => @posting }
      else
        format.js
        format.xml  { render :xml => @posting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @posting = Posting.find(params[:id])

    respond_to do |format|
      if @posting.update_attributes(params[:posting])
        @notice = 'Posting successfully updated.'
        format.js
        format.xml  { head :ok }
      else
        format.js
        format.xml  { render :xml => @posting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @posting = Posting.find(params[:id])
    @posting.destroy

    respond_to do |format|
      format.html { redirect_to(postings_url) }
      format.xml  { head :ok }
    end
  end
end

