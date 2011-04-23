module PostingsHelper
  def sidenav_content
    
    if action_name =~ /inventory/
      inv_class = 'current'
      req_class = ''
    elsif action_name =~ /request/
      inv_class = ''
      req_class = 'current'
    else
      inv_class = ''
      req_class = ''
    end
    
    # Change where the links take you, depending on if you are on the
    # services, products, or my tab.
    if action_name =~ /services/
      inv_path = services_inventory_postings_path
      req_path = services_requests_postings_path
    elsif action_name =~ /products/
      inv_path = products_inventory_postings_path
      req_path = products_requests_postings_path
    elsif action_name =~ /my/
      inv_path = my_inventory_postings_path
      req_path = my_requests_postings_path
    else
      inv_path = home_path
      req_path = home_path
    end
    
    return '<li>'+link_to('Offering',
                          inv_path,
                          :class => inv_class) +
           '</li><li>'+link_to('Looking For',
                               req_path,
                               :class => req_class)+'</li>'  
  end
  
  def topnav_content
    if action_name =~ /services/
      serv_class = 'current'
      prod_class = ''
      my_class = ''
    elsif action_name =~ /products/
      serv_class = ''
      prod_class = 'current'
      my_class = ''
    elsif action_name =~ /my/
      serv_class = ''
      prod_class = ''
      my_class = 'current'
    end
    
    return '<li>' + link_to('Products',
                            products_requests_postings_path,
                            :class => prod_class) + '</li>' +
           '<li>' + link_to('Services',
                            services_requests_postings_path,
                            :class => serv_class) + '</li>' +
           '<li>' + link_to('My Stuff',
                            my_inventory_postings_path,
                            :class => my_class) + '</li>'
  end
end

