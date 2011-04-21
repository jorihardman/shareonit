class ChangeMessagesToOffers < ActiveRecord::Migration
  def self.up
    drop_table :messages
    create_table "offers", :force => true do |t|
      t.integer  "posting_id"
      t.integer  "offerer_id"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :offers
    reate_table "messages", :force => true do |t|
      t.integer  "sender_id"
      t.integer  "receiver_id"
      t.string   "subject"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end

