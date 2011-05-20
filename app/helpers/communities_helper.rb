module CommunitiesHelper

  def community_table_row(community)
    output = '' <<
    "<tr id=\"community_#{community.id}\">" <<
    "<td>#{community.name}</td>" <<
    "<td>#{community.description}</td>" <<
    "<td>#{community.zip_code}</td>" <<
    '<td class="buttonset">'
    if current_user.id != community.user_id
      output << link_to('Request membership', request_community_path(community), :remote => true)
    else
      output << link_to('Show', community_path(community))
    end
    output << '</td></tr>'
  end

end
