class AddFreeToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :free, :boolean, :default => true
  end

  def self.down
    remove_column :postings, :free
  end
end
