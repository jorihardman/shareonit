class RemoveStatusFromPostings < ActiveRecord::Migration
  def self.up
    remove_column :postings, :status
  end

  def self.down
    add_column :postings, :status, :string, :default => 'pending'
  end
end
