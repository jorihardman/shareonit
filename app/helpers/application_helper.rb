module ApplicationHelper
  def login_link
    if current_user
      return link_to 'Logout ' << current_user.full_name, logout_path, :method => :delete
    else
      return link_to 'Login', login_path
    end
  end

  def navigation_content
    requests_class = action_name == 'requests' ? 'current' : ''
    inventory_class = action_name == 'inventory' ? 'current' : ''
    my_stuff_class = action_name == 'my_stuff' ? 'current' : ''

    return "<li>#{link_to 'We Need', requests_postings_path, :class => requests_class}</li>" <<
           "<li>#{link_to 'Our Inventory', inventory_postings_path, :class => inventory_class}</li>" <<
           "<li>#{link_to 'My Stuff', my_stuff_postings_path, :class => my_stuff_class}</li>"
  end
end

