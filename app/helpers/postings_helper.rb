module PostingsHelper
  def new_posting_link
    product_service = action_name =~ /service/ ? 'service' : 'product'
    have_need = action_name =~ /inventory/ ? 'have' : 'need'
    link_to 'Create New Posting',
      new_posting_path(:product_service => product_service, :have_need => have_need),
      :rel => 'facebox'
  end

  def posting_table_row(posting)
    '<tr>' << "<td>#{link_to posting.name, posting}</td>" <<
    "<td>#{posting.from_date}</td>" << "<td>#{posting.to_date}</td>" <<
    "<td>#{posting.user.full_name}</td>" << "<td>#{posting.status}</td>" <<
    '</tr>'
  end

  def offer_table_row(offer)
    '<tr>' << "<td>#{offer.user.full_name}</td>" <<
    "<td>#{offer.message}</td>" << "<td>#{offer.status}</td>" <<
    "<td>#{link_to 'Edit Offer', edit_posting_offer_path(offer.posting_id, offer.id), :remote => true, :method => :post}</td>" <<
    '</tr>'
  end

end

