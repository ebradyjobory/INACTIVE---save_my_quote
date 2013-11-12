require 'test_helper'

class UserTest < ActiveSupport::TestCase

should have_many :user_friendships
should have_many :friends
 
 test "a user should enter a first name" do 
 	user = User.new
 	assert !user.save
 	assert !user.errors[:first_name].empty?
 end

 test "a user should enter a last name" do 
 	user = User.new
 	assert !user.save
 	assert !user.errors[:last_name].empty?
 end

  test "a user should enter a profile name" do 
 	user = User.new
 	assert !user.save
 	assert !user.errors[:profile_name].empty?
 end

 test "a user should have a unique profile name" do
 	user = User.new
 	user.profile_name = "ejoubori"
 	user.email = "essam.joubori@gmail.com"
 	user.first_name = "Essam"
 	user.last_name = "Joubori"
 	user.password = "password"
 	user.password_confirmation = "password"
 	assert !user.save
 	assert !user.errors[:profile_name].empty?	
 end

 test "a user should have a profile name without spaces" do
   user = User.new(first_name: "Essam", last_name: "Joubori", email: "hulubaba@gmail.com")
   user.password = user.password_confirmation = "password"

   user.profile_name = "My profile with spaces"
   assert !user.save
   assert !user.errors[:profile_name].empty?
   assert user.errors[:profile_name].include?("must be formatted correctly")
 end

test "a user can have a correctly formatted profile name" do
user = User.new(first_name: "Essam", last_name: "Joubori", email: "hulubaba@gmail.com")
user.password = user.password_confirmation = "password"

user.profile_name = "hulubaba"
assert user.valid?

end

test "that no error raised when trying to access friend list" do
   assert_nothing_raised do
   users(:essam).friends
  end
end

test "that creating friendship on a user works" do
	users(:tim).pending_friends << users(:miwa)
	users(:tim).pending_friends.reload
	assert users(:tim).pending_friends.include?(users(:miwa))
end

test "that calling to_param on a user return the profile name" do
   assert_equal "ejoubori", users(:essam).to_param
  end


end
