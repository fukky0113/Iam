require "test_helper"

class PostsPostTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:one)
    @post = posts(:post_hoge)
    @admin_user = users(:admin_user)
    @user = users(:user)
  end

  test "successful post" do
    log_in_as(@admin_user)
    post posts_path, params: {post: {title: "test", category_id: @post.category_id}}
    follow_redirect!
    assert_template "posts/index"
  end

end
