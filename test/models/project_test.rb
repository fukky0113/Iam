require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @company = companies(:one)
    @project = Project.new(summary: "test", incharge: "test", achivement: "test", start_on: "2002/2/2", end_on: "2002/2/3", user_id: @admin_user.id, company_id: @company.id)
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "summary should be present" do
    @project.summary = " "
    assert_not @project.valid?
  end

  test "incharge should be present" do
    @project.incharge = " "
    assert_not @project.valid?
  end

  test "achivement should be present" do
    @project.achivement = " "
    assert_not @project.valid?
  end

  test "start_on should be present" do
    @project.start_on = " "
    assert_not @project.valid?
  end

  test "end_on should be present" do
    @project.end_on = " "
    assert_not @project.valid?
  end
end
