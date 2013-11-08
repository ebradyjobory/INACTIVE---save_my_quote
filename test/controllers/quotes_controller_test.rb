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
      post :create, quote: { content: @quote.content }
    end
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

