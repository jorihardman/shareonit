module PostingsHelper

  def posting_div(posting)
    if current_user.id != posting.user_id
      link_text = 'Offer' if params[:scope] == 'requests'
      if params[:scope] == 'inventory'
        if posting.for_sale
          link_text = posting.free ? 'Take' : 'Buy'
        else
          link_text = 'Borrow'
        end
      end
      buttonset = link_to(link_text, posting, :rel => 'facebox')
    else
      buttonset = link_to('Edit', edit_posting_path(posting), :rel => 'facebox') <<
      link_to('Delete', posting_path(posting), :method => :delete, :remote => true, :confirm => 'Are you sure?')
    end
    
    unless posting.photo_file_name.blank?
      image = '<div class="photo">' <<
        link_to(image_tag(posting.photo.url(:thumb)), posting.photo.url, :rel => 'facebox') <<
        '</div>'
    end
    
    if params[:scope] == 'my_stuff'
      subtext = "I #{posting.have ? 'have' : 'want'} this"
    else
      subtext = (posting.have ? 'Posted' : 'Requested') << ' by ' << posting.user.full_name
    end
    subtext << ' in ' << link_to(posting.category, request_path(:category => posting.category))
    
    if posting.free
      price = 'FREE to ' << (posting.for_sale ? 'take' : 'borrow')
    else
      price = number_to_currency(posting.price, :unit => '$') << ' to ' << (posting.for_sale ? 'buy' : 'borrow')
    end
    
    raw <<-TEXT
      <div id="posting_#{posting.id}" class="list_element"> 
        <div class="list_left">
          #{image}
          <div class="description">
            #{link_to posting.description, posting_path(posting), :rel => 'facebox'}
          </div>
          <div class="subtext">
            #{subtext}
          </div>
        </div>
        <div class="list_right">
          <div class="price">
            #{price}
          </div>
          <div class="buttonset">#{buttonset}</div>
        </div>
      </div>
    TEXT
  end
  
end

