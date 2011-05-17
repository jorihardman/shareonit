class FeedbackController < ApplicationController
  
  def index
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def submit_feedback
    message = params[:feedback_text]
    Notifier.delay.feedback(current_user, message)
    
    respond_to do |format|
      format.js
    end
  end
end
