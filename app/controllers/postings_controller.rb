class PostingsController < ApplicationController
  before_filter :require_user

  def index
    redirect_to :action => "requests"
  end

  def requests
    @postings = Posting.requests

    respond_to do |format|
      format.html { render :template => "postings/index" }
      format.xml { render :xml => @postings }
    end
  end

  def inventory
    @postings = Posting.inventory

    respond_to do |format|
      format.html { render :template => "postings/index" }
      format.xml { render :xml => @postings }
    end
  end

  def show
    @posting = Posting.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @posting }
    end
  end

  def new
    @posting = Posting.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @posting }
    end
  end

  def edit
    @posting = Posting.find(params[:id])
  end

  def create
    @posting = Posting.new(params[:posting])
    @posting.from_date = Date.strptime(params[:posting][:from_date], "%m/%d/%Y")
    @posting.to_date = Date.strptime(params[:posting][:to_date], "%m/%d/%Y")

    respond_to do |format|
      if @posting.save
        format.html { redirect_to(@posting, :notice => 'Posting was successfully created.') }
        format.xml  { render :xml => @posting, :status => :created, :location => @posting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @posting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @posting = Posting.find(params[:id])

    respond_to do |format|
      if @posting.update_attributes(params[:posting])
        format.html { redirect_to(@posting, :notice => 'Posting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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

