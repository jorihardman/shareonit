class UpdatePostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :community_id, :integer, :null => false
    add_column :postings, :price, :integer, :default => 0
    remove_column :postings, :from_date
    remove_column :postings, :to_date
  end

  def self.down
    remove_column :postings, :community_id
    remove_column :postings, :price
    add_column :postings, :from_date, :date
    add_column :postings, :to_date, :date
  end
end
