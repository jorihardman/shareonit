class FixInvitations < ActiveRecord::Migration
  def self.up
    rename_column :invitations, :group_id, :community_id
  end

  def self.down
    rename_column :invitations, :community_id, :group_id
  end
end
