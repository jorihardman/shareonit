module PostingsHelper

  def posting_div(posting)
    buttonset = ''
    if current_user.id != posting.user_id
      link_text = ''
      if action_name == 'requests'
        link_text = 'Offer'
      elsif action_name == 'inventory'
        link_text = posting.for_sale ? 'Buy' : 'Borrow'
      end
      buttonset << link_to(link_text, posting, :rel => 'facebox')
    else
      buttonset << link_to('Edit', edit_posting_path(posting), :rel => 'facebox') <<
      link_to('Delete', posting_path(posting), :method => :delete, :remote => true, :confirm => 'Are you sure?')
    end
    
    unless posting.photo_file_name.blank?
      image = '<div class="photo">' <<
        link_to(image_tag(posting.photo.url(:thumb)), posting.photo.url, :rel => 'facebox') <<
        '</div>'
    end
    
    subtext = "<div class=\"subtext\">"
    if action_name != 'my_stuff'
      subtext << "Posted by #{posting.user.full_name}"
    else
      subtext << "I #{posting.have ? 'have' : 'want'} this"
    end
    subtext << " in #{link_to posting.category, :action => action_name, :category => posting.category}</div>"
    
    output = <<-TEXT
      <div id="posting_#{posting.id}" class="list_element"> 
        <div class="list_left">
          #{image}
          <div class="description">
            #{link_to posting.description, posting_path(posting), :rel => 'facebox'}
          </div>
          #{subtext}
        </div>
        <div class="list_right">
          <div class="price">
            #{posting.price == 0 ? 'FREE' : number_to_currency(posting.price, :unit => '$')}
            to #{posting.for_sale ? 'buy' : 'borrow'}
          </div>
          <div class="buttonset">#{buttonset}</div>
        </div>
      </div>
    TEXT
    
    return output
  end
  
end

