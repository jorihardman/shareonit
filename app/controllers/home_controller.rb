class HomeController < ApplicationController
  
  def application
    respond_to do |format|
      format.js
    end
  end

  def about
  end

  def contact_us
  end
  
end
