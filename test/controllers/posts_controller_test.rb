require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:hoge1)
    @user = users(:hogefuga)
  end

  test "should get new" do
    log_in_as(@user)
    get new_post_path
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get post_path(@post)
    assert_response :success
  end

  test "should get index" do
    log_in_as(@user)
    get posts_path
    assert_response :success
  end

  test "Redirect at destroy time" do
    log_in_as(@user)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_response :see_other
    assert_redirected_to posts_path
  end
end
