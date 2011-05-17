class AddDeletedToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :deleted, :boolean, :default => false
  end

  def self.down
    remove_column :postings, :deleted
  end
end
