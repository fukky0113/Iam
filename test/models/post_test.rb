require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @admin_user = users(:admin_user)
    @category = categories(:one)
    @post = Post.new(title: "test", user_id: @admin_user.id, category_id: @category.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "post should be present" do
    @post.title = " "
    assert_not @post.valid?
  end
end
