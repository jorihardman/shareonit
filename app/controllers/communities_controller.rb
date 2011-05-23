class CommunitiesController < ApplicationController
  before_filter :require_user

  def index
    @communities = Community.all
    @invitations = Invitation.where(:email => current_user.email)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @communities }
    end
  end

  def show
    @community = Community.find(params[:id])
    @members = @community.memberships.where(:accepted => true).paginate(:page => params[:mem_page])
    @requests = @community.memberships.where(:accepted => false).paginate(:page => params[:req_page])

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
    @community.send_invitations(params[:emails])

    respond_to do |format|
      if @community.save
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
    @community.send_invitations(params[:emails])
    
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
    @community.destroy

    respond_to do |format|
      format.html { redirect_to(communities_path) }
      format.xml  { head :ok }
    end
  end
  
end
