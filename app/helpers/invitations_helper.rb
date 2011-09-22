module InvitationsHelper
    
  def invitation_table_row(invitation)
    raw <<-END
      <tr id="invitation_#{invitation.id}">
        <td>#{h invitation.community.name}</td>
        <td>#{h invitation.community.description}</td>
        <td>#{invitation.community.zip_code}</td>
        <td class="buttonset">
          #{link_to('Accept', accept_community_invitation_path(invitation.community_id, invitation), :remote => true)}
          #{link_to('Reject', community_invitation_path(invitation.community_id, invitation), :remote => true, :method => :delete)}
        </td>
      </tr>
    END
  end
    
end
