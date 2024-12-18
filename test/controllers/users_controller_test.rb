require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hogefuga)
    @other_user = users(:archer)
  end

  test "should get new" do
    log_in_as(@user)
    get new_user_url
    assert_response :success
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              user_id: @user.user_id}}
    assert_redirected_to root_url
  end
end
