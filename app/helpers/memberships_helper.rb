module MembershipsHelper

  def membership_table_row(membership)
    button = if membership.accepted
      link_to('Remove', community_membership_path(membership.community_id, membership), :method => :delete, 
          :confirm => "Are you sure?", :remote => true)
    else
      link_to('Accept', accept_community_membership_path(membership.community_id, membership),
          :remote => true)
    end
    
    raw <<-TEXT
      <tr id=\"membership_#{membership.id}\">
        <td>#{h membership.user.full_name}</td>
        <td>#{h membership.user.email}</td>
        <td class="buttonset">
          #{button}
        </td>
      </tr>
    TEXT
  end
  
end