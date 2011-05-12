class RemoveProductServices < ActiveRecord::Migration
  def self.up
    remove_column :postings, :product_service
  end

  def self.down
    add_column :postings, :product_service, :string
  end
end
