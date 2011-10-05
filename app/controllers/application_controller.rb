class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :request_url, :request_path, :current_user, :current_user_session

  private
  
  def request_url(params={})
    @request_path ||= ActionController::Routing::Routes.recognize_path(request.path)
    url_for(@request_path.merge(params))
  end
  
  def request_path(params={})
    parsed_url = URI.parse(request_url(params))
    query = parsed_url.query.to_s
    parsed_url.path.to_s << (query.blank? ? '' : '?' << query)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = 'You must be logged in to access this page'
      store_location
      redirect_to login_path
      return false
    end
  end

  def require_no_user
    if current_user
      redirect_to inventory_postings_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
