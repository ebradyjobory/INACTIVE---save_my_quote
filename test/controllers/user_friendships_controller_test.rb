require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
    context "#new" do
  	 context "when not logged in" do
  	 	should "redireced to the login page" do
  	 		get :new
  	 		assert_response :redirect
        end
      end
      context "when logged in" do
      	setup do
      		sign_in users(:essam)
      	end

      	should "get new and return success" do
      	get :new
      	assert_response :success
      end

      should "should set a flash error of the friend_id params is missing" do
        get :new, {}
        assert_equal "Friend required", flash[:error]
      end

      should "display the friend's name" do
      	get :new, friend_id: users(:tim).id
      	assert_match /#{users(:tim).full_name}/, response.body

      end

      should "assign a new user friendship to the correct friend" do
      	get :new, friend_id: users(:tim).id
      	assert_equal users(:tim), assigns(:user_friendship).friend
      end


      should "assign a new user friendship to the correct logged in user" do
      	get :new, friend_id: users(:tim).id
      	assert_equal users(:essam), assigns(:user_friendship).user

      end

      should "returns 404 status if no friend is found" do
      	get :new, friend_id: 'invalid'
      	assert_response :not_found
      end

      should "ask if you really want request this friendship" do
        get :new, friend_id: users(:tim)
        assert_match /Do you really want to friend #{users(:tim).full_name}?/, response.body
      end
      end
   end


















end
