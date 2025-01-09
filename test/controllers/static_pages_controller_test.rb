require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test "should get home" do
    get root_path
    assert_response :success
  end

  test "if you are log in, should not home" do
    log_in_as(@user)
    get root_path
    assert_response :see_other
    assert_redirected_to posts_path
  end
end