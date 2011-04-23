class ChangeOfferFields < ActiveRecord::Migration
  def self.up
    rename_column :offers, :offerer_id, :user_id
    rename_column :offers, :content, :message
  end

  def self.down
    rename_column :offers, :user_id, :offerer_id
    rename_column :offers, :message, :content
  end
end

