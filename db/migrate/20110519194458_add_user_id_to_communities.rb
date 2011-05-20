class AddUserIdToCommunities < ActiveRecord::Migration
  def self.up
    add_column :communities, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :communities, :user_id
  end
end
