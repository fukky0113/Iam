require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hogefuga)
  end


  test "invalid signup information" do
    log_in_as(@user)
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {user_id:  "",
                                        name:     "hoge",
                                        password: "hoge",
                                        password_confirmation: "hoge"}}
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "valid signup information" do
    log_in_as(@user)
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: {name:     "fugafuga",
                                        user_id:  "@fugafuga",
                                        password: "fugafuga",
                                        password_confirmation: "fugafuga"}}
    end
    follow_redirect!
    assert_template 'posts/index'
  end

end