module InvitationsHelper
    
    def invitation_table_row(invitation)
      output = '' <<
      "<tr id=\"invitation_#{invitation.id}\">" <<
      "<td>#{invitation.community.name}</td>" <<
      "<td>#{invitation.community.description}</td>" <<
      "<td>#{invitation.community.zip_code}</td>" <<
      "<td class=\"buttonset\">" << 
      link_to('Accept', accept_community_invitation_path(invitation.community_id, invitation), :remote => true) <<
      link_to('Reject', community_invitation_path(invitation.community_id, invitation), :remote => true, :method => :delete) <<
      "</td></tr>"
    end
    
end
