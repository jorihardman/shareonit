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

  def sidenav_content
    inv_class = (action_name =~ /inventory/) ? 'current' : ''
    if action_name =~ /services/
      inv_path = services_inventory_postings_path
    elsif action_name =~ /products/
      inv_path = products_inventory_postings_path
    else
      inv_path = my_inventory_postings_path
    end

    req_class = (action_name =~ /requests/) ? 'current' : ''
    if action_name =~ /services/
      req_path = services_requests_postings_path
    elsif action_name =~ /products/
      req_path = products_requests_postings_path
    else
      req_path = my_requests_postings_path
    end

    return "<li>#{link_to('We Need',req_path, :class => req_class)}</li>" <<
           "<li>#{link_to('We Have', inv_path, :class => inv_class)}</li>"
  end

  def topnav_content
    prod_class = (action_name =~ /products/) ? 'current' : ''
    prod_path = (action_name =~ /inventory/) ? products_inventory_postings_path : products_requests_postings_path

    serv_class = (action_name =~ /services/) ? 'current' : ''
    serv_path = (action_name =~ /inventory/) ? services_inventory_postings_path : services_requests_postings_path

    my_stuff_class = (action_name =~ /my/) ? 'current' : ''
    my_stuff_path = (action_name =~ /inventory/) ? my_inventory_postings_path : my_requests_postings_path

    return "<li>#{link_to 'Products', prod_path, :class => prod_class}</li>" <<
           "<li>#{link_to 'Services', serv_path, :class => serv_class}</li>" <<
           "<li>#{link_to 'My Stuff', my_stuff_path, :class => my_stuff_class}</li>"
  end
end

