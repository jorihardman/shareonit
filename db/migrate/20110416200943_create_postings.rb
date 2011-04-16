class CreatePostings < ActiveRecord::Migration
  def self.up
    create_table :postings do |t|
      t.string :type
      t.string :name
      t.text :description
      t.date :from_date
      t.date :to_date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :postings
  end
end

