require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @user = users(:user)
    @company = companies(:one)
    @unused_project = projects(:two)
  end

  # test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_user_project_path(@admin_user)
    assert_response :success
  end

  test "should not get new (not administrator)" do
    log_in_as(@user)
    get new_user_project_path(@user)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should not get new (not log in)" do
    get new_user_project_path(@user)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test create
  test "should create project" do
    log_in_as(@admin_user)
    assert_difference 'Project.count' do
      post user_projects_path(@admin_user), params: { project: { summary: "test",
                                                                 incharge: "test",
                                                                 achivement: "test",
                                                                 start_on: "2022/2/1",
                                                                 end_on: "2022/2/2",
                                                                 user_id: @admin_user.id,
                                                                 company_id: @company.id,
                                                                 project_skill: { skill_id: ["1"] } } }
    end
    assert_response :see_other
    assert_redirected_to posts_path
  end

  test "should create project (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Project.count' do
      post user_projects_path(@admin_user), params: { project: { summary: "test",
                                                                 incharge: "test",
                                                                 achivement: "test",
                                                                 start_on: "2022/2/1",
                                                                 end_on: "2022/2/2",
                                                                 user_id: @admin_user.id,
                                                                 company_id: @company.id,
                                                                 project_skill: { skill_id: ["1"] } } }
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should create project (not log in)" do
    assert_no_difference 'Project.count' do
      post user_projects_path(@admin_user), params: { project: { summary: "test",
                                                                 incharge: "test",
                                                                 achivement: "test",
                                                                 start_on: "2022/2/1",
                                                                 end_on: "2022/2/2",
                                                                 user_id: @admin_user.id,
                                                                 company_id: @company.id,
                                                                 project_skill: { skill_id: ["1"] } } }
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test delete
  test "redirect at destroy time" do
    log_in_as(@admin_user)
    assert_difference 'Project.count', -1 do
      delete user_project_path(user_id: @admin_user.id, id: @unused_project.id)
    end
    assert_redirected_to posts_path
  end

  test "should not delete (not administrator)" do
    log_in_as(@user)
    assert_no_difference 'Project.count' do
      delete user_project_path(user_id: @user.id, id: @unused_project.id)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should not delete (not log in)" do
    assert_no_difference 'Project.count' do
      delete user_project_path(user_id: @admin_user.id, id: @unused_project.id)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test edit
  test "should get edit" do
    log_in_as(@admin_user)
    get edit_user_project_path(user_id: @admin_user.id, id: @unused_project.id)
    assert_response :success
  end

  test "should not get edit (not administrator)" do
    log_in_as(@user)
    get edit_user_project_path(user_id: @user.id, id: @unused_project.id)
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should not get edit (not log in)" do
    get edit_user_project_path(user_id: @admin_user.id, id: @unused_project.id)
    assert_response :see_other
    assert_redirected_to login_url
  end

  # test update
  test "should update project" do
    log_in_as(@admin_user)
    patch user_project_path(user_id: @admin_user.id, id: @unused_project.id),
          params: {
            project: {
              summary: "test",
              incharge: "test",
              achivement: "test",
              start_on: "2022/2/1",
              end_on: "2022/2/2",
              user_id: @admin_user.id,
              company_id: @company.id,
              project_skill: { skill_id: ["1"] }
            }
          }
    assert_redirected_to posts_path
  end

  test "should update project (not administrator)" do
    log_in_as(@user)
    patch user_project_path(user_id: @admin_user, id: @unused_project.id),
          params: { project: { summary: "test",
                               incharge: "test",
                               achivement: "test",
                               start_on: "2022/2/1",
                               end_on: "2022/2/2",
                               user_id: @admin_user.id,
                               company_id: @company.id,
                               project_skill: { skill_id: ["1"] } } }
    assert_redirected_to root_url
  end

  test "should update project (not log in)" do
    patch user_project_path(user_id: @user, id: @unused_project.id),
          params: { project: { summary: "test",
                               incharge: "test",
                               achivement: "test",
                               start_on: "2022/2/1",
                               end_on: "2022/2/2",
                               user_id: @admin_user.id,
                               company_id: @company.id,
                               project_skill: { skill_id: ["1"] } } }
    assert_response :see_other
    assert_redirected_to login_path
  end
end
