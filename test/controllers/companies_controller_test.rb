require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get company_new_url
    assert_response :success
  end
end
