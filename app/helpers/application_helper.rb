module ApplicationHelper
  def login_link
    if current_user
      return link_to 'Logout ' << current_user.full_name, session_path, :method => :delete
    else
      return link_to 'Login', new_session_path
    end
  end

  def back_or_default_link(text, default)
    link_to text, (defined?(session[:return_to]) ? session[:return_to] : default)
  end

  def communities_content
    "Community Stuff"
  end

  def topnav_content
    requests_class = action_name == 'requests' ? 'current' : ''
    inventory_class = action_name == 'inventory' ? 'current' : ''
    my_stuff_class = action_name == 'my_stuff' ? 'current' : ''

    return "<li>#{link_to 'We Need', requests_postings_path, :class => requests_class}</li>" <<
           "<li>#{link_to 'We Have', inventory_postings_path, :class => inventory_class}</li>" <<
           "<li>#{link_to 'My Stuff', my_stuff_postings_path, :class => my_stuff_class}</li>"
  end
end

