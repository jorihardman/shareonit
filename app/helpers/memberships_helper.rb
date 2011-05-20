module MembershipsHelper
  def membership_table_row(membership)
    output = '' << 
    "<tr id=\"membership_#{membership.id}\">" << 
    "<td>#{membership.user.full_name}</td>" <<
    "<td>#{membership.user.email}</td>" << 
    '<td class="buttonset">'
    if membership.accepted
      output << link_to('Remove', community_membership_path(membership.community_id, membership), :method => :delete, :remote => true)
    else
      output << link_to('Accept', accept_community_membership_path(membership.community_id, membership), :method => :put, :remote => true)
    end
    output << '</td></tr>'
  end
end
