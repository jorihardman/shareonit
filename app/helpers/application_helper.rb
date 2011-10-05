module ApplicationHelper

  def login_link
    if current_user
      return link_to "Logout #{current_user.full_name}", logout_path, :method => :delete
    else
      return link_to 'Login', login_path
    end
  end

  def navigation_content
    requests_class = params[:scope] == 'requests' ? 'current' : ''
    inventory_class = params[:scope] == 'inventory' ? 'current' : ''
    my_stuff_class = params[:scope] == 'my_stuff' ? 'current' : ''
    communities_class = controller_name == 'communities' ? 'current' : ''

    raw <<-END
      <li>#{link_to 'Stuff People Have', inventory_postings_path, :class => inventory_class}</li>
      <li>#{link_to 'Stuff People Want', requests_postings_path, :class => requests_class}</li>
      <li>#{link_to 'My Stuff', my_stuff_postings_path, :class => my_stuff_class}</li>
      <li>#{link_to 'Communities', communities_path, :class => communities_class}</li>
    END
  end
  
end

