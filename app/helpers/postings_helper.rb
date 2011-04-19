module PostingsHelper
  def nav_content
    if action_name =~ /services/
      return '<li>'+link_to('Inventory', services_inventory_postings_path)+
             '</li><li>'+link_to('Requests', services_requests_postings_path)+'</li>'
    else
      return '<li>'+link_to('Inventory', products_inventory_postings_path)+
             '</li><li>'+link_to('Requests', products_requests_postings_path)+'</li>'
    end
  end
end

