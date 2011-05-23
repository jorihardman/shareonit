class AddEmailIndexForInvitations < ActiveRecord::Migration
  def self.up
    add_index :invitations, :email
  end

  def self.down
    remove_index :invitations, :email
  end
end
