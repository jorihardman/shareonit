class FeedbackController < ApplicationController
  before_filter :require_user 
  
  def index
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def submit_feedback
    message = params[:feedback_text]
    Notifier.feedback(current_user, message).deliver
    
    respond_to do |format|
      format.js
    end
  end
end
