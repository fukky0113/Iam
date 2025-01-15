require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin_user)
    @user = users(:user)
    @category = categories(:one)
    @unuser_category = categories(:two)
  end

  #test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_category_path
    assert_response :success
  end

  test "if you are not an administrator, should not get new" do
    log_in_as(@user)
    get new_category_path
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "if you are not log in, should not get new" do
    get new_category_path
    assert_response :see_other
    assert_redirected_to login_url
  end

  #test delete
  test "Redirect at destroy time" do
    log_in_as(@admin_user)
    assert_difference 'Category.count', -1 do
      delete category_path(@unuser_category)
    end
    assert_redirected_to new_category_path
  end

  test "if you are not an administrator, should not delete" do
    log_in_as(@user)
    assert_no_difference 'Category.count' do
      delete category_path(@category)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "if you are not log in, should not delete" do
    assert_no_difference 'Category.count' do
      delete category_path(@category)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  #test create
  test "should create post" do
    log_in_as(@admin_user)

    assert_difference 'Category.count' do
      post categories_path, params: {category: {category: "test"}}
    end
    
    assert_redirected_to new_category_path
  end

  test "if you are not an administrator, should not create" do
    log_in_as(@user)
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {category: "test"}}
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "if you are not log in, should not create" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {category: "test"}}
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

end
