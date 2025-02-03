require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  # test new
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should not get new (log in)" do
    log_in_as(@user)
    get login_path
    assert_response :see_other
    assert_redirected_to posts_path
  end

  # test create
  test "should create session" do
    get login_path
    post login_path, params: { session: { user_id: "@duchess",
                                          password: "password",
                                          password_confirmation: "password" } }
    assert_response :see_other
    assert_redirected_to posts_path
  end

  test "should not create session (incorrect)" do
    get login_path
    post login_path, params: { session: { user_id: "@incorrect",
                                          password: "incorrect",
                                          password_confirmation: "incorrect" } }
    assert_response :unprocessable_entity
    assert_template "sessions/new"
  end

  test "should not create session (log in)" do
    log_in_as(@user)
    post login_path, params: { session: { user_id: "@duchess",
                                          password: "password",
                                          password_confirmation: "password" } }
    assert_response :see_other
    assert_redirected_to posts_path
  end

  # test destroy
  test "should destroy session" do
    log_in_as(@user)
    delete logout_path(@user)
    assert_not_equal @user.user_id, cookies[:user_id]
    assert_response :see_other
    assert_redirected_to root_url
  end
end
