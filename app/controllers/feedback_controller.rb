class FeedbackController < ApplicationController
  def index
  end

  def submit_feedback
    message = params[:feedback_text]
    Notifier.feedback(current_user,message).deliver
    
    redirect_to(home_path)
  end
end
