require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @company = Company.new(company_name: "test", user_id: @admin_user.id)
  end

  test "should be valid" do
    assert @company.valid?
  end

  test "company should be present" do
    @company.company_name = " "
    assert_not @company.valid?
  end

  test "company should be unique" do
    duplicate_company = @company.dup
    @company.save
    assert_not duplicate_company.valid?
  end
end
