class CreatePostingsCommunities < ActiveRecord::Migration
  def self.up
    remove_column :postings, :community_id
    create_table "communities_postings", :id => false, :force => true do |t|
      t.integer "posting_id", :null => false
      t.integer "community_id", :null => false
    end
  end

  def self.down
    add_column :postings, :community_id, :integer, :null => false
    drop_table :communities_postings
  end
end
