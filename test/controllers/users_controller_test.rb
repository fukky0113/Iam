require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @user = users(:user)
  end

  # test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_user_url
    assert_response :success
  end

  test "if you are not an administrator, should not new" do
    log_in_as(@user)
    get new_user_url
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should not new" do
    get new_user_url
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test index
  test "should get index" do
    log_in_as(@admin_user)
    get users_path
    assert_response :success
  end

  test "if you are not administrator should get index" do
    log_in_as(@user)
    get users_path
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should get index" do
    get users_path
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test show
  test "should get show" do
    log_in_as(@admin_user)
    get user_path(@admin_user)
    assert_response :success
  end

  test "if you are not administrator, should get show" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should get show" do
    get user_path(@user)
    assert_response :see_other
    assert_redirected_to login_url
  end

  #test edit
  test "should get edit" do
    log_in_as(@admin_user)
    get edit_user_path(@admin_user)
    assert_response :success
  end

  test "if you are not administrator, should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should get edit" do
    get edit_user_path(@user)
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test update
  test "should update user" do
    log_in_as(@admin_user)
    patch user_path(@admin_user), params: { user: { name: @admin_user.name,
                                              user_id: @admin_user.user_id}}
    assert_redirected_to posts_path
  end

  test "if you are not log in, should update user" do
    patch user_path(@admin_user), params: { user: { name: @admin_user.name,
                                              user_id: @admin_user.user_id}}
    assert_response :see_other
    assert_redirected_to login_path
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch user_path(@admin_user), params: { user: { name: @admin_user.name,
                                              user_id: @admin_user.user_id}}
    assert_redirected_to root_url
  end

  # test delete
  test "should delete user" do
    log_in_as(@admin_user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to users_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@admin_user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy when in as a non-admin" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      delete user_path(@admin_user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  # test create
  test "should create user" do
    log_in_as(@admin_user)
    assert_difference 'User.count', +1 do
      post users_path, params: {user: {name: "test",
                                        user_id: "@test",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'posts/index'
  end

  test "should not create user when not logged in" do
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "test",
                                        user_id: "@test",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  test "should not create user when logged in as a non-admin user" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "test",
                                        user_id: "@test",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  # test profile
  test "should get profile" do
    log_in_as(@admin_user)
    get profile_user_path(@admin_user)
    assert_response :success
  end

  test "should get profile (not admin)" do
    log_in_as(@user)
    get profile_user_path(@user)
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should get profile (not log in)" do
    get profile_user_path(@admin_user)
    assert_response :see_other
    assert_redirected_to login_path
  end
end
