require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(category: "test")
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "category should be present" do
    @category.category = " "
    assert_not @category.valid?
  end
  
  test "category should be unique" do
    duplicate_category = @category.dup
    @category.save
    assert_not duplicate_category.valid?
  end
end
