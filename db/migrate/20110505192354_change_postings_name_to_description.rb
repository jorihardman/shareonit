class ChangePostingsNameToDescription < ActiveRecord::Migration
  def self.up
    rename_column :postings, :name, :description
  end

  def self.down
    rename_column :postings, :description, :name
  end
end
