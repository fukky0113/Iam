require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  test "successful post" do
    post  posts_path, params: { posts: {title: "hello"}}
    follow_redirect!
    assert_template "posts/index"
  end

end
