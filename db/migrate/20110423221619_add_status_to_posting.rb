class AddStatusToPosting < ActiveRecord::Migration
  def self.up
    add_column :postings, :status, :string, :default => 'pending'
  end

  def self.down
    remove_column :postings, :status
  end
end

