module CommunitiesHelper

  def community_table_row(community)
    membership = Membership.where('user_id = ? AND community_id = ?', current_user.id, community.id).first
    if current_user.id == community.user_id
      button = link_to('Manage', community_path(community))
    elsif membership.nil? 
      button = link_to('Request membership', community_memberships_path(community), :remote => true, :method => :post)
    elsif not membership.accepted
      button = 'Request pending approval...'
    else
      button = link_to('Leave Group', community_membership_path(community, membership), :remote => true, :method => :delete, :confirm => 'Are you sure?')
    end
    
    raw <<-END
      <tr id="community_#{community.id}">
        <td>#{h community.name}</td>
        <td>#{community.zip_code}</td>
        <td>#{community.memberships.where(:accepted => true).count}</td>
        <td class="buttonset">
          #{button}
        </td>
      </tr>
    END
  end
  
end
