class ChangeCommunityDescriptionToString < ActiveRecord::Migration
  def self.up
    change_column :communities, :description, :string
  end

  def self.down
    change_column :communities, :description, :text
  end
end
