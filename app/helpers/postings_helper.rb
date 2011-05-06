module PostingsHelper
  def new_posting_link
    product_service = action_name =~ /service/ ? 'service' : 'product'
    have_need = action_name =~ /inventory/ ? 'have' : 'need'
    link_to 'Create New Posting',
      new_posting_path(:product_service => product_service, :have_need => have_need),
      :rel => 'facebox', :class => 'button'
  end

  def posting_table_row(posting)
    output = ''
    output << '<td>' << posting.description << '</td><td>' <<
    "#{posting.from_date}" << '</td><td>' << "#{posting.to_date}" << '</td><td>' <<
    posting.user.full_name << '</td><td class="buttonset">'
    if current_user.id != posting.user_id
      output << link_to(action_name =~ /requests/ ? 'Offer' : 'Borrow', posting, :rel => 'facebox')
    else
      output << link_to('Edit', edit_posting_path(posting), :rel => 'facebox') <<
      link_to('Delete', posting_path(posting), :method => :delete, :remote => true, :confirm => 'are you sure?')
    end
    output << '</td>'
  end
end

