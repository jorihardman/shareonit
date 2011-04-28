class AddNamesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :null => false
    add_column :users, :last_name, :string, :null => false
    remove_column :users, :login
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :login, :string, :null => false
  end
end

