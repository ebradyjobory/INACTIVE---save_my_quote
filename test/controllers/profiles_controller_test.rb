require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:essam).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

 test "show render a 404 on profile not found" do
   get :show, id: "doesn't exist"
   assert_response :not_found
end

test "that variables are assigned on successful profile viewing" do
   get :show, id: users(:essam).profile_name
   assert assigns(:user)
   assert_not_empty assigns(:quotes)
end

test "only shows the correct user's quote" do
	get :show, id: users(:essam).profile_name
	assigns(:quotes).each do |quote|
		assert_equal users(:essam), quote.user
	end

end
end
