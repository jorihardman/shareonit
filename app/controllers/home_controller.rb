class HomeController < ApplicationController
  def index
    redirect_to(my_account_path) if current_user
    @user_session = UserSession.new
    @user = User.new
  end

  def about
  end

  def contact_us
  end
end
