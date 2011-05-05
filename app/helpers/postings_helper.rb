module PostingsHelper
  def new_posting_link
    product_service = action_name =~ /service/ ? 'service' : 'product'
    have_need = action_name =~ /inventory/ ? 'have' : 'need'
    link_to 'Create New Posting',
      new_posting_path(:product_service => product_service, :have_need => have_need),
      :rel => 'facebox'
  end

  def posting_table_row(posting)
    "<td>#{posting.description}</td>" <<
    "<td>#{posting.from_date}</td>" << "<td>#{posting.to_date}</td>" <<
    "<td>#{posting.user.full_name}</td>" <<
    "<td>#{link_to 'Edit', edit_posting_path(posting), :rel => 'facebox'}</td>"
  end

end

