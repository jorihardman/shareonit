class RemoveDescriptionFromPostings < ActiveRecord::Migration
  def self.up
    remove_column :postings, :description
  end

  def self.down
    add_column :postings, :description, :text
  end
end

