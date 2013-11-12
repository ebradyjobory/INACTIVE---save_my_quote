require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
  	assert_nothing_raised do
  	UserFriendship.create user: users(:essam), friend: users(:miwa)
     end
  end
  test "that creating friendship based on user id and friend id works" do
	UserFriendship.create user_id: users(:tim).id, friend_id: users(:miwa).id
	assert users(:tim).pending_friends.include?(users(:miwa))
	end

    context "a new instance" do
    setup do
      @user_friendship = UserFriendship.new user: users(:tim), friend: users(:mike)
  end

  should "have a pending state" do
    assert_equal 'pending', @user_friendship.state
  end
end 

  context "#send_request_email" do
    setup do
      @user_friendship = UserFriendship.create user: users(:tim), friend: users(:mike)
  end

  should "send and email" do
    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      @user_friendship.send_request_email
    end

  end

 end

   context "#accept!" do
    setup do
      @user_friendship = UserFriendship.create user: users(:tim), friend: users(:mike)

    end

    should "set the state to accepted" do
      @user_friendship.accept!
      assert_equal "accepted", @user_friendship.state

    end

    should "send an accepted email" do
      assert_difference "ActionMailer::Base.deliveries.size", 1 do
         @user_friendship.accept!
      end
    end

    should "include the friend in the list of friend" do
      @user_friendship.accept!
      users(:tim).friends.reload
      assert users(:tim).friends.include?(users(:mike))
    end
   end

   context ".request" do
    should "create two user friendships" do
      assert_difference "UserFriendship.count", 2 do
        UserFriendship.request(users(:miwa), users(:tim))

       end
     end

     should "send a friend request email" do
      assert_difference "ActionMailer::Base.deliveries.size", 1 do
        UserFriendship.request(users(:miwa), users(:tim))
        end
     end
   end
end
