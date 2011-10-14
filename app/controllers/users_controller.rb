class UsersController < ApplicationController

  def new
    @user = User.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Account created!'
        format.js
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.js
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end