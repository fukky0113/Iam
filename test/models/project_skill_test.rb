require "test_helper"

class ProjectSkillTest < ActiveSupport::TestCase
  def setup
    @project_skill = ProjectSkill.new(project_id: 1, skill_id: 1)
  end

  test "The combination of ProjectID and SkillID must be unique." do
    @duplicate_project = @project_skill.dup
    @project_skill.save
    assert_not @project_skill.valid?
  end
end
