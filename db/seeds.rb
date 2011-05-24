2.times do |i|
  id = i+1
  User.create(:first_name => 'Test', :last_name => "User #{id}", :email => "test#{id}@test.com", :password => 'password', :password_confirmation => 'password')
end
