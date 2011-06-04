class AddCategoriesToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :category, :string, :null => false
    Posting.all.each do |posting|
      posting.update_attribute(:category, 'Other')
    end
  end

  def self.down
    remove_column :postings, :category
  end
end
