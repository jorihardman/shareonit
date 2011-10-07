class PostingsController < ApplicationController

  before_filter :require_user
  before_filter :require_owner, :only => ['edit', 'update', 'destroy']
  before_filter :require_community

  def index
    redirect_to inventory_postings_path and return if request_path == postings_path
    
    @postings = case params[:scope]
    when 'inventory' then Posting.search_or_where(params, ['have = ?', true])
    when 'requests' then Posting.search_or_where(params, ['have = ?', false])
    else Posting.search_or_where(params, ['postings.user_id = ?', current_user.id])  
    end
  
    respond_to do |format|
      format.html
      format.xml  { render :xml => @postings }
    end
  end

  def show
    @posting = Posting.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @posting }
    end
  end

  def new
    @posting = Posting.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @posting }
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
    @posting.communities.clear
    @posting.update_attribute(:deleted, true)

    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end
  end
  
  def email
    @posting = Posting.find(params[:id])
    Notifier.delay.offer(@posting, params[:message], current_user)
    @posting.add_to_inventory if params[:add_to_inventory]
  
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
  
  def require_community
    if current_user.active_communities.count == 0
      redirect_to communities_path, 
        :notice => 'You don\'t have any active communities! Activate a community or request membership to a new one to start sharing.'
      return false
    end
  end
  
end