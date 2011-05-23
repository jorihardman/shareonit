# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
2.times do |i|
  id = i+1
  User.create(:first_name => 'Test', :last_name => "User #{id}", :email => "test#{id}@test.com", :password => 'password', :password_confirmation => 'password')
end

Community.create(:name => 'Test Community 1', :description => 'For testing communities.', :zip_code => 60201, :user_id => 1)

User.all.each do |user|
  Membership.create(:user_id => user.id, :community_id => 1, :accepted => true, :active => true)  
end

