class FeedbackController < ApplicationController
  
  def index
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def submit_feedback
    Notifier.delay.feedback(params[:feedback_text], current_user)
    
    respond_to do |format|
      format.js
    end
  end
  
end
