require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:hogefuga)
  end

  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {user_id: "", password: ""}}
    assert_response :unprocessable_entity
    assert_template "sessions/new"
    get root_path
  end
  
  test "login with valid information" do
    post login_path, params: {session: {user_id: @user.user_id, password: 'hogefuga' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end
end
