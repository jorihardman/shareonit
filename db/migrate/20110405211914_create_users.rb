class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   "login", :null => false
      t.string   "email", :null => false
      t.string   "crypted_password", :null => false
      t.string   "password_salt", :null => false
      t.string   "persistence_token", :null => false
      t.string   "single_access_token", :null => false
      t.string   "perishable_token", :null => false
      t.integer  "login_count", :default => 0, :null => false
      t.datetime "last_request_at"
      t.datetime "last_login_at"
      t.datetime "current_login_at"
      t.string   "last_login_ip"
      t.string   "current_login_ip"

      t.timestamps
    end

    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end

  def self.down
    drop_table :users
  end
end

