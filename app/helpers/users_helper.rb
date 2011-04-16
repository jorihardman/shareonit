module UsersHelper
  def follow(guide_id)
    if current_user.id != guide_id
      if UserRelationship.where({:follower_id => current_user.id, :guide_id => params[:id]}).first.nil?
        return "<p>#{button_to 'Follow', follow_user_path(params[:id]), :remote => true}</p>"
      else
        return "<p>#{button_to 'Unfollow', unfollow_user_path(params[:id]), :remote => true, :method => :delete}</p>"
      end
    else
      return ''
    end
  end
end
