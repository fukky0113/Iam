require "test_helper"

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @user = users(:user)
    @skill = skills(:one)
    @user_skills = user_skills(:one)
  end
  
  # test new
  test "should get new" do
    log_in_as(@admin_user)
    get new_user_user_skill_path(@admin_user)
    assert_response :success
    assert_template "user_skills/new"
  end

  test "should get new (not admin)" do
    log_in_as(@user)
    get new_user_user_skill_path(@user)
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should get new (not log in)" do
    get new_user_user_skill_path(@admin_user)
    assert_response :see_other
    assert_redirected_to login_path
  end

  #test create
  test "should create user_skills" do
    log_in_as(@admin_user)
    assert_difference 'UserSkill.count' do
      post user_user_skills_path(@admin_user), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id} }
    end
    assert_response :see_other
    assert_redirected_to posts_path
  end

  test "should create user_skills (not admin)" do
    log_in_as(@user)
    assert_no_difference 'UserSkill.count' do
      post user_user_skills_path(@user), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id} }
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should create user_skills (not log in)" do
    assert_no_difference 'UserSkill.count' do
      post user_user_skills_path(@admin_user), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id} }
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test edit
  test "should get edit" do
    log_in_as(@admin_user)
    get edit_user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    assert_response :success
    assert_template "user_skills/edit"
  end

  test "should get edit (not admin)" do
    log_in_as(@user)
    get edit_user_user_skill_path(user_id: @user.id, id: @user_skills.id)
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should get edit (not log in)" do
    get edit_user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    assert_response :see_other
    assert_redirected_to login_path
  end

  #test update
  test "should update user_skills" do
    log_in_as(@admin_user)
    get edit_user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    patch user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id, detail: "test"} }
    assert_response :see_other
    assert_redirected_to posts_path
    @user_skills.reload
    assert_equal "test", @user_skills.detail
  end

  test "should update user_skills (not admin)" do
    log_in_as(@user)
    get edit_user_user_skill_path(user_id: @user.id, id: @user_skills.id)
    patch user_user_skill_path(user_id: @user.id, id: @user_skills.id), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id, detail: "test"} }
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should update user_skills (not log in)" do
    get edit_user_user_skill_path(user_id: @user.id, id: @user_skills.id)
    patch user_user_skill_path(user_id: @user.id, id: @user_skills.id), params: { user_skill: {user_id: @admin_user.id, skill_id: @skill.id, detail: "test"} }
    assert_response :see_other
    assert_redirected_to login_path
  end

  # test delete
  test "should delete user_skills" do
    log_in_as(@admin_user)
    assert_difference 'UserSkill.count', -1 do
      delete user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    end
    assert_response :see_other
    assert_redirected_to posts_path
  end

  test "should delete user_skills(not administrator)" do
    log_in_as(@user)
    assert_no_difference 'UserSkill.count' do
      delete user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    end
    assert_response :see_other
    follow_redirect!
    assert_redirected_to posts_path
  end

  test "should delete user_skills (not log in)" do
    assert_no_difference 'UserSkill.count' do
      delete user_user_skill_path(user_id: @admin_user.id, id: @user_skills.id)
    end
    assert_response :see_other
    assert_redirected_to login_path
  end

end
