class CreateCommunities < ActiveRecord::Migration
  def self.up
    create_table :communities do |t|
      t.string :name
      t.integer :zip_code
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :communities
  end
end
