module ApplicationHelper
  def login_link
    if current_user
      return link_to 'Logout '+current_user.login.capitalize, session_path, :method => :delete
    else
      return link_to 'Login', new_session_path
    end
  end
end
