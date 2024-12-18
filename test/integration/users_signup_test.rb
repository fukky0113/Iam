require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hogefuga)
  end


  test "invalid signup information" do
    log_in_as(@user)
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {user_id:  "@hoge",
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
      post users_path, params: { user: {user_id:  "@hogehoge",
                                        name:     "hoge",
                                        password: "hogehoge",
                                        password_confirmation: "hogehoge"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end

end