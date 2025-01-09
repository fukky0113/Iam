require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
  end
end

class InvalidPasswordTest < UsersLogin
  test "login path" do
    get login_path
    assert_template "sessions/new"
  end

  test "login with valid userid/invalid password" do
    post login_path, params: {session: {user_id: "", password: ""}}
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template "sessions/new"
    get root_path
  end
end

class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: {session: {user_id: @user.user_id, password: 'password' } }
  end
end

class ValidLoginTest < ValidLogin
  test "valid login" do
    assert is_logged_in? 
    assert_redirected_to posts_path
  end

  test "redirect after login" do
    follow_redirect!
    assert_template 'posts/index'
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test "successful logout" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "redirect after logout" do
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should still work after logout in second window" do
    delete logout_path
    assert_redirected_to root_url
  end

  class RememberingTest < UsersLogin
    test "login with remembering" do
      log_in_as(@user, remember_me: "1")
      assert_not cookies[:remember_token].blank?
    end

    test "login without remembering" do
      log_in_as(@user, remember_me: "1")
      log_in_as(@user, remember_me: "0")
      assert cookies[:remember_token].blank?
    end
  end
end