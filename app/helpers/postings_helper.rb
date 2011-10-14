module PostingsHelper

  def posting_div(posting)
    buttonset = if current_user.id != posting.user_id
      link_text = if params[:scope] == 'inventory'
        if posting.for_sale
          posting.free ? 'Take' : 'Buy'
        else
          'Borrow'
        end
      elsif params[:scope] == 'requests'
        'Offer'
      end
      link_to(link_text, posting, :rel => 'facebox')
    else
      link_to('Edit', edit_posting_path(posting), :rel => 'facebox') <<
          link_to('Delete', posting_path(posting), :method => :delete, :remote => true, :confirm => 'Are you sure?')
    end
    
    unless posting.photo_file_name.blank?
      image = <<-TEXT
        <div class="photo">
          #{link_to image_tag(posting.photo.url(:thumb)), posting.photo.url, :rel => 'facebox'}
        </div>
      TEXT
    end
    
    subtext = if params[:scope] == 'my_stuff'
      "I #{posting.have ? 'have' : 'want'} this"
    else
      "#{posting.have ? 'Posted' : 'Requested'} by #{posting.user.full_name}"
    end
    subtext << "in #{link_to posting.category, request_path(:category => posting.category)}"
    
    price = if posting.free
      "FREE to #{posting.for_sale ? 'take' : 'borrow'}"
    else
      "#{number_to_currency(posting.price, :unit => '$')} to #{posting.for_sale ? 'buy' : 'borrow'}"
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