class PostingsController < ApplicationController
  before_filter :require_user
  before_filter :require_owner, :only => ['edit', 'update', 'destroy']

  def index
    respond_to do |format|
      format.html { redirect_to :action => 'products_requests' }
      format.js
    end
  end

  def my_stuff
    @requests = Posting.search_or_where(params[:search], {:have_need => 'need', :user_id => current_user.id}, params[:page])
    @inventory = Posting.search_or_where(params[:search], {:have_need => 'have', :user_id => current_user.id}, params[:page])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @requests + @inventory }
    end
  end

  def inventory
    store_location
    @postings = Posting.search_or_where(params[:search], ['have_need = ? and user_id != ?', 'have', current_user.id], params[:page])

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def requests
    store_location
    @postings = Posting.search_or_where(params[:search], ['have_need = ? and user_id != ?', 'need', current_user.id], params[:page])

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @postings }
    end
  end

  def show
    @posting = Posting.find(params[:id])

    respond_to do |format|
      format.js
      format.html { render :layout => false }
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
      format.js
      format.xml  { head :ok }
    end
  end
  
  def email
    posting = Posting.find(params[:id])
    Notifier.offer(current_user, posting, params[:message]).deliver
    posting.add_to_inventory(current_user) if params[:add_to_inventory]
  
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def require_owner
    if Posting.find(params[:id]).user_id != current_user.id
      redirect_to root_path, :notice => 'Sorry, but you don\'t own that posting.'
      return false
    end
  end
end

