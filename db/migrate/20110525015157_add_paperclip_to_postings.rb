class AddPaperclipToPostings < ActiveRecord::Migration
  def self.up
    add_column :postings, :have, :boolean, :null => false
    Posting.reset_column_information
    Posting.all.each do |posting|
      posting.have = posting.have_need == 'have' ? true : false
    end
    remove_column :postings, :have_need
    
    add_column :postings, :photo_file_name,    :string
    add_column :postings, :photo_content_type, :string
    add_column :postings, :photo_file_size,    :integer
    add_column :postings, :photo_updated_at,   :datetime
    add_column :postings, :photo_processing,   :boolean
  end

  def self.down
    add_column :postings, :have_need, :string, :null => false
    Posting.reset_column_information
    Posting.all.each do |posting|
      posting.have_need = user.have? ? 'have' : 'need'
    end
    remove_column :postings, :have
    
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
    add_column :postings, :photo_processing
  end
end
