class MinimizeSchema < ActiveRecord::Migration
  def self.up
    drop_table :offers
    drop_table :reviews
  end

  def self.down
    create_table "offers", :force => true do |t|
      t.integer  "posting_id"
      t.integer  "user_id"
      t.text     "message"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "status",     :default => "pending"
    end
    
    create_table "reviews", :force => true do |t|
      t.integer  "reviewer_id"
      t.integer  "reviewee_id"
      t.integer  "posting_id"
      t.text     "content"
      t.integer  "stars"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
