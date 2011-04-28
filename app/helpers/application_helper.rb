module ApplicationHelper
  def login_link
    if current_user
      return link_to 'Logout ' << current_user.login.capitalize, session_path, :method => :delete
    else
      return link_to 'Login', new_session_path
    end
  end

  def sidenav_content
    inv_class = (action_name =~ /inventory/) ? 'current' : ''
    inv_path = (action_name =~ /services/) ? services_inventory_postings_path : products_inventory_postings_path

    req_class = (action_name =~ /requests/) ? 'current' : ''
    req_path = (action_name =~ /services/) ? services_requests_postings_path : products_requests_postings_path

    return "<li>#{link_to('Inventory', inv_path, :class => inv_class)}</li>" <<
           "<li>#{link_to('Requests',req_path, :class => req_class)}</li>"
  end

  def topnav_content
    prod_class = (action_name =~ /products/) ? 'current' : ''
    prod_path = (action_name =~ /inventory/) ? products_inventory_postings_path : products_requests_postings_path

    serv_class = (action_name =~ /services/) ? 'current' : ''
    serv_path = (action_name =~ /inventory/) ? services_inventory_postings_path : services_requests_postings_path

    return "<li>#{link_to('Products', prod_path, :class => prod_class)}</li>" <<
           "<li>#{link_to('Services', serv_path, :class => serv_class)}</li>"
  end
end

