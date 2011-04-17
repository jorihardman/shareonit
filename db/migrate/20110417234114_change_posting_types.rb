class ChangePostingTypes < ActiveRecord::Migration
  def self.up
    remove_column :postings, :posting_type
    add_column :postings, :have_need, :string
    add_column :postings, :product_service, :string
  end

  def self.down
    remove_column :postings, :have_need
    remove_column :postings, :product_service
    add_column :postings, :posting_type
  end
end

