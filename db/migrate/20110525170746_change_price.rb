class ChangePrice < ActiveRecord::Migration
  def self.up
    change_column :postings, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    change_column :postings, :price, :integer, :default => 0
  end
end
