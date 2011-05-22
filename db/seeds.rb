# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create(:first_name => 'Test', :last_name => 'User 1', :email => 'test1@test.com', :password => 'password', :password_confirmation => 'password')
User.create(:first_name => 'Test', :last_name => 'User 2', :email => 'test2@test.com', :password => 'password', :password_confirmation => 'password')
Community.create(:name => 'Test Community 1', :description => 'For testing communities.', :zip_code => 60201, :user_id => 1)
Community.create(:name => 'Test Community 2', :description => 'For testing communities.', :zip_code => 60201, :user_id => 1)
User.all.each do |user|
  Membership.create(:user_id => user.id, :community_id => 1, :accepted => true, :active => true)  
  Membership.create(:user_id => user.id, :community_id => 2, :accepted => true, :active => true)
end

