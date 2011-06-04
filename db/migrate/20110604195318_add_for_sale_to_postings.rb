class AddForSaleToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :for_sale, :boolean, :default => false
    Posting.all.each do |posting|
      posting.for_sale = posting.free ? false : true
      posting.save
    end
  end

  def self.down
    remove_column :postings, :for_sale
  end
end
