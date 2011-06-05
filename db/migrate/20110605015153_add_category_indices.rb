class AddCategoryIndices < ActiveRecord::Migration
  def self.up
    add_index :postings, :category
    add_index :postings, :free
  end

  def self.down
    remove_index :postings, :category
    remove_index :postings, :free
  end
end
