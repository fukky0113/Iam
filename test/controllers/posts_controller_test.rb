require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:one)
    @post = posts(:post_hoge)
    @admin_user = users(:admin_user)
    @user = users(:user)
  end

  # test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_post_path
    assert_response :success
  end

  test "if you are not an administrator, should not get new" do
    log_in_as(@user)
    get new_post_path
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should not get new" do
    get new_post_path
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test show
  test "should get show" do
    log_in_as(@admin_user)
    get post_path(@post)
    assert_response :success
  end

  test "if you are not an administrator, should get show" do
    log_in_as(@user)
    get post_path(@post)
    assert_response :success
  end

  test "if you are not log in, should not get show" do
    get post_path(@post)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test index
  test "should get index" do
    log_in_as(@admin_user)
    get posts_path
    assert_response :success
  end

  test "if you are not an administrator, should get index" do
    log_in_as(@user)
    get posts_path
    assert_response :success
  end

  test "if you are not log in, should not get index" do
    get posts_path
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test delete
  test "Redirect at destroy time" do
    log_in_as(@admin_user)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_response :see_other
    assert_redirected_to posts_path
  end

  test "if you are not an administrator, should not delete" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "if you are not log in, should not delete" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test create
  test "should create post" do
    log_in_as(@admin_user)

    assert_difference 'Post.count' do
      post posts_path, params: {post: {title: "test", category_id: @category.id}}
    end
    
    assert_redirected_to posts_path
  end

  test "if you are not an administrator, should not create" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {title: "test", category_id: "1"}}
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "if you are not log in, should not create" do
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {title: "test"}}
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

end
