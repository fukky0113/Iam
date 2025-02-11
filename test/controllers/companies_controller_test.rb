require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @user = users(:user)
    @company = companies(:one)
    @unused_company = companies(:two)
  end

  # test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_user_company_path(@admin_user)
    assert_response :success
  end

  test "should not get new (not administrator)" do
    log_in_as(@user)
    get new_user_company_path(@user)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should not get new (not log in)" do
    get new_user_company_path(@admin_user)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test create
  test "should create post" do
    log_in_as(@admin_user)
    assert_difference 'Company.count' do
      post user_companies_path(@admin_user), params: { company: { company_name: "test", user_id: @admin_user.id } }
    end
    assert_redirected_to new_user_company_path
  end

  test "should not create (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Company.count' do
      post user_companies_path(@user), params: { company: { company_name: "test", user_id: @user.id } }
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not create (not log in)" do
    assert_no_difference 'Company.count' do
      post user_companies_path(@user), params: { company: { company_name: "test", user_id: @user.id } }
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test delete
  test "redirect at destroy time" do
    log_in_as(@admin_user)
    assert_difference 'Company.count', -1 do
      delete user_company_path(user_id: @admin_user.id, id: @unused_company.id)
    end
    assert_redirected_to new_user_company_path
  end

  test "should not delete (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Company.count' do
      delete user_company_path(user_id: @user.id, id: @unused_company.id)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not delete (not log in)" do
    assert_no_difference 'Company.count' do
      delete user_company_path(user_id: @admin_user.id, id: @unused_company.id)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

end
