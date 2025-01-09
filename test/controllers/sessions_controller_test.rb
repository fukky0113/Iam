require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "if you are log in, should not new" do
    log_in_as(@user)
    get login_path
    assert_response :see_other
    assert_redirected_to posts_path
  end
end
