module CommunitiesHelper

  def community_table_row(community)
    membership = Membership.where('user_id = ? AND community_id = ?', current_user.id, community.id).first
    output = '' <<
    "<tr id=\"community_#{community.id}\">" <<
    "<td>#{community.name}</td>" <<
    #"<td>#{community.description}</td>" <<
    "<td>#{community.zip_code}</td>" <<
    "<td>" << (membership ? "#{membership.active ? 'Active' : 'Inactive'}" : '') << "</td>" <<
    '<td class="buttonset">'
    if current_user.id == community.user_id
      output << link_to(membership.active ? 'Deactivate' : 'Activate', community_membership_path(community, membership), :remote => true, :method => :put)
      output << link_to('Manage', community_path(community))
    elsif membership.nil? 
      output << link_to('Request membership', community_memberships_path(community), :remote => true, :method => :post)
    elsif not membership.accepted
      output << 'Request pending approval...'
    else
      output << link_to(membership.active ? 'Deactivate' : 'Activate', community_membership_path(community, membership), :remote => true, :method => :put)
      output << link_to('Leave Group', community_membership_path(community, membership), :remote => true, :method => :delete, :confirm => 'Are you sure?')
    end
    output << '</td></tr>'
  end
  
end
