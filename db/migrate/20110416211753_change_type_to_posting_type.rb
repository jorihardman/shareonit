class ChangeTypeToPostingType < ActiveRecord::Migration
  def self.up
    remove_column :postings, :type
    add_column :postings, :posting_type, :string
  end

  def self.down
    remove_column :postings, :posting_type
    add_column :postings, :type, :string
  end
end

