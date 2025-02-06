require "test_helper"

class UserSkillTest < ActiveSupport::TestCase
  def setup
    @user_skill = UserSkill.new(user_id: 1, skill_id: 1)
  end

  test "The combination of UserID and SkillID must be unique." do
    @duplicate_user = @user_skill.dup
    @user_skill.save
    assert_not @user_skill.valid?
  end
end
