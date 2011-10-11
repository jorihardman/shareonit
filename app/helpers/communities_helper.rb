module CommunitiesHelper

  def community_div(community)
    membership = Membership.where('user_id = ? AND community_id = ?', current_user.id, community.id).first
    if current_user.id == community.user_id
      button = link_to('Manage', community_path(community))
    elsif membership.nil? 
      button = link_to('Request membership', community_memberships_path(community), :remote => true, :method => :post)
    elsif not membership.accepted
      button = 'Request pending approval...'
    else
      button = link_to('Leave Group', community_membership_path(community, membership), :remote => true,
          :method => :delete, :confirm => 'Are you sure?')
    end
    
    raw <<-TEXT
      <div id="community_#{community.id}" class="list_element"> 
        <div class="list_left">
          <div class="description">
            #{h community.name}
          </div>
          <div class="subtext">
            Zip: #{community.zip_code}<br/>
            #{h community.description}
          </div>
        </div>
        <div class="list_right">
          <div class="members">
            #{community.memberships.where(:accepted => true).count} Members
          </div>
          <div class="buttonset">#{button}</div>
        </div>
      </div>
    TEXT
  end
  
end