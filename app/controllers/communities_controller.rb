class CommunitiesController < ApplicationController
  def index
    @communities = Community.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @communities }
    end
  end

  def show
    @community = Community.find(params[:id])

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
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @community = Community.new(params[:community])

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

    respond_to do |format|
      if @community.update_attributes(params[:community])
        format.html { redirect_to(@community, :notice => 'Community was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @community.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy

    respond_to do |format|
      format.html { redirect_to(communities_url) }
      format.xml  { head :ok }
    end
  end
end
