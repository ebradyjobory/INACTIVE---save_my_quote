require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  setup do
    @quote = quotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end

  test "user create quote for the current user when logged in" do
   sign_in users(:essam)
   assert_difference('Quote.count') do
      post :create, quote: { content: @quote.content, user_id: users(:tim).id }
   end
     assert_redirected_to quote_path(assigns(:quote))
     assert_equal assigns(:quote).user_id, users(:essam).id
  end

   test "user update quote for the current user when logged in" do
   sign_in users(:essam)
   put :update, id: @quote, quote: { content: @quote.content, user_id: users(:tim).id}
   assert_redirected_to quote_path(assigns(:quote))
   assert_equal assigns(:quote).user_id, users(:essam).id
  end


  test "should not update the quote if nothing has changed" do
   sign_in users(:essam)
   put :update, id: @quote
   assert_redirected_to quote_path(assigns(:quote))
   assert_equal assigns(:quote).user_id, users(:essam).id
  end

  test "should be redirected when not login" do
    get :new
    assert_response :redirect
    assert_redirected_to  new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:essam)
    get :new
    assert_response :success
  end

  test "should be logged in to post new status" do
  post :create, quote: {content: "Hello"}
  assert_response :redirect
  assert_redirected_to new_user_session_path
end


  test "should create quote when loggeg in" do
    sign_in users(:essam)
    assert_difference('Quote.count') do
      post :create, quote: { content: @quote.content, user_id: users(:essam).id }
    end
    assert_redirected_to quote_path(assigns(:quote))
  end

  test "should edit quote when loggeg in" do
    sign_in users(:essam)
    get :edit, id: @quote
    assert_response :success
    end

  test "should update quote when loggeg in" do
   
    get :update, id: @quote
    assert_response :redirect
    assert_redirected_to new_user_session_path
    end

  test "should show quote" do
    get :show, id: @quote
    assert_response :success
  end

  test "should destroy quote" do
    assert_difference('Quote.count', -1) do
      delete :destroy, id: @quote
    end

    assert_redirected_to quotes_path
  end

end

