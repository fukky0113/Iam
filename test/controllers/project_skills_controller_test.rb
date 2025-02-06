require "test_helper"

class ProjectSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_skills_new_url
    assert_response :success
  end
end
