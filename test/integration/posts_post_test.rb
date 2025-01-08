require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hogefuga)
  end

  test "successful post" do
    log_in_as(@user)
    post posts_path, params: { post: {title: "hello"}}
    follow_redirect!
    assert_template "posts/index"
  end

end
