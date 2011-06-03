module PostingsHelper

  def posting_div(posting)
    buttonset = ''
    if current_user.id != posting.user_id
      link_text = ''
      if action_name == 'requests'
        link_text = 'Offer'
      elsif action_name == 'inventory'
        link_text = posting.free ? 'Borrow' : 'Buy'
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
    
    output = <<-TEXT
      <div id="posting_#{posting.id}" class="list-element"> 
        <div class="list-left">
          #{image}
          #{posting.description}
        </div>
        <div class="list-right">
          #{posting.user.full_name}<br/>
          Price: #{posting.free ? 'FREE' : number_to_currency(posting.price, :unit => '$')}<br/>
          <div class="buttonset">#{buttonset}</div>
        </div>
      </div>
    TEXT
    
    return output
  end
  
end

