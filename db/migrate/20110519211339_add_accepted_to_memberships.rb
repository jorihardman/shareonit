class AddAcceptedToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :accepted, :boolean, :default => false
    change_column :memberships, :active, :boolean, :default => false
  end

  def self.down
    remove_column :memberships, :accepted
    change_column :memberships, :active, :boolean, :default => true
  end
end
