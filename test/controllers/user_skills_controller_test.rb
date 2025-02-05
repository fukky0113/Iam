require "test_helper"

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_skills_new_url
    assert_response :success
  end
end
