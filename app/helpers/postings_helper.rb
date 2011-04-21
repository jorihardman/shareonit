module PostingsHelper
  def sidenav_content
    if action_name =~ /inventory/
      inv_class = 'current'
      req_class = ''
    else
      inv_class = ''
      req_class = 'current'
    end
    
    if action_name =~ /services/
      inv_path = services_inventory_postings_path
      req_path = services_requests_postings_path
    else
      inv_path = products_inventory_postings_path
      req_path = products_requests_postings_path
    end
    
    return '<li>'+link_to('Inventory',
                          inv_path,
                          :class => inv_class) +
           '</li><li>'+link_to('Requests',
                               req_path,
                               :class => req_class)+'</li>'  
  end
  
  def topnav_content
    if action_name =~ /services/
      serv_class = 'current'
      prod_class = ''
    else
      serv_class = ''
      prod_class = 'current'
    end
    
    return '<li>' + link_to('Products',
                            products_requests_postings_path,
                            :class => prod_class) + '</li>' +
           '<li>' + link_to('Services',
                            services_requests_postings_path,
                            :class => serv_class) + '</li>' +
           '<li><a href="#">My Stuff</a></li>'
  end
end

