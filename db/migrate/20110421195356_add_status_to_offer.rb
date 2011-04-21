class AddStatusToOffer < ActiveRecord::Migration
  def self.up
    add_column :offers, :status, :string, :default => 'pending'
  end

  def self.down
    remove_column :offers, :status
  end
end

