require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hogefuga)
  end

  test "unsuccessful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit" 
    patch user_path(@user), params: {user: { name: "",
                                                user_id: "@invalid",
                                                password:              "foo",
                                                password_confirmation: "bar"}}
    assert_template "users/edit"
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    name = "FooBar"
    user_id = "@success"
    patch user_path(@user), params: { user: { name: name,
                                              user_id: user_id,
                                              password:   "",
                                              password_confirmation: ""}}
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal user_id, @user.user_id
  end
end
