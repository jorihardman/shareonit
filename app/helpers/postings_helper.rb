module PostingsHelper

  def posting_table_row(posting)
    output = '' << 
    "<tr id=\"posting_#{posting.id}\">" <<
    "<td>#{posting.description}</td>" <<
    "<td>#{posting.user.full_name}</td>" << 
    "<td>#{posting.free ? 'FREE' : number_to_currency(posting.price, :unit => '$')}</td>" << 
    "<td>" 
    unless posting.photo_file_name.nil?
      output << link_to(image_tag(posting.photo.url(:thumb)), posting.photo.url, :rel => 'facebox')
    end
    output << '</td><td class="buttonset">'
    if current_user.id != posting.user_id
      link_text = ''
      if action_name == 'requests'
        link_text = 'Offer'
      elsif action_name == 'inventory'
        link_text = posting.free ? 'Borrow' : 'Buy'
      end
      output << link_to(link_text, posting, :rel => 'facebox')
    else
      output << link_to('Edit', edit_posting_path(posting), :rel => 'facebox') <<
      link_to('Delete', posting_path(posting), :method => :delete, :remote => true, :confirm => 'Are you sure?')
    end
    output << '</td></tr>'
  end
  
end

