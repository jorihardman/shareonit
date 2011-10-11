class CommunitiesController < ApplicationController
  
  before_filter :require_user
  before_filter :require_owner, :only => ['show', 'edit', 'update', 'destroy']

  def index
    @all_communities = Community.search(params[:search], params[:page]).
        order('communities.name ASC').
        paginate(:page => params[:all_page], :per_page => 5)
    @user_communities = current_user.communities.
        order('communities.name ASC').
        paginate(:page => params[:user_page], :per_page => 5)
    @invitations = Invitation.where(:email => current_user.email)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @communities }
    end
  end

  def show
    @community = Community.find(params[:id])
    @members = @community.memberships.where(:accepted => true).paginate(:page => params[:mem_page], :per_page => 10)
    @requests = @community.memberships.where(:accepted => false).paginate(:page => params[:req_page], :per_page => 10)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @community }
    end
  end

  def new
    @community = Community.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @community }
    end
  end

  def edit
    @community = Community.find(params[:id])
  
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @community = Community.new(params[:community])

    respond_to do |format|
      if @community.save
        @community.send_invitations(params[:emails])
        format.js
        format.xml  { render :xml => @community, :status => :created, :location => @community }
      else
        format.js
        format.xml  { render :xml => @community.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @community = Community.find(params[:id])
    
    respond_to do |format|
      if @community.update_attributes(params[:community])
        format.js
        format.xml  { head :ok }
      else
        format.js
        format.xml  { render :xml => @community.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.postings.clear
    @community.destroy

    respond_to do |format|
      format.html { redirect_to(communities_path) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def require_owner
    if Community.find(params[:id]).user_id != current_user.id
      redirect_to root_path, :notice => 'Sorry, but you don\'t own that community.'
      return false
    end
  end
  
end