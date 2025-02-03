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
    assert_template "posts/new"
  end

  test "should not get new (not administrator)" do
    log_in_as(@user)
    get new_post_path
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should not get new (not log in)" do
    get new_post_path
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test show
  test "should get show" do
    log_in_as(@admin_user)
    get post_path(@post)
    assert_response :success
    assert_template "posts/show"
  end

  test "should get show (not administrator)" do
    log_in_as(@user)
    get post_path(@post)
    assert_response :success
    assert_template "posts/show"
  end

  test "should not get show (not log in)" do
    get post_path(@post)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test index
  test "should get index" do
    log_in_as(@admin_user)
    get posts_path
    assert_response :success
    assert_template "posts/index"
  end

  test "should get index (not administrator)" do
    log_in_as(@user)
    get posts_path
    assert_response :success
    assert_template "posts/index"
  end

  test "should not get index (not log in)" do
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

  test "should not delete (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not delete (not log in)" do
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

  test "should not create (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {title: "test", category_id: "1"}}
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not create (not log in)" do
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {title: "test"}}
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test edit
  test "should get edit" do
    log_in_as(@admin_user)
    get edit_post_path(@post)
    assert_response :success
    assert_template "posts/edit"
  end

  test "should not get edit (not administrator)" do
    log_in_as(@user)
    get edit_post_path(@post)
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not edit (not log in)" do
    get edit_post_path(@post)
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test update
  test "should update post" do
    log_in_as(@admin_user)
    patch post_path(@post), params: {post: {title: "test1"}}
    assert_response :see_other
    assert_redirected_to @post
  end

  test "should not update post(not administrator)" do
    log_in_as(@user)
    patch post_path(@post), params: {post: {title: "test1"}}
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not update post(not post)" do
    patch post_path(@post), params: {post: {title: "test1"}}
    assert_response :see_other
    assert_redirected_to login_path
  end

end
