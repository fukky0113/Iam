require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Hello World", user_id: "@hello_wold", 
                      password: "password", password_confirmation: "password")
  end


# 有効性
  test "should be valid" do
    assert @user.valid?
  end

# 存在性
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "user_id should be present" do
    @user.user_id = " "
    assert_not @user.valid?
  end

# 長さ
  test "name should not be too long" do
    @user.name = "@" + "a" * 11
    assert_not @user.valid?
  end

  test "user_id should not be too long" do
    @user.user_id = "@" + "a" * 11
    assert_not @user.valid?
  end

# フォーマット
  test "user_id validation should accept valid id" do
    @user.user_id = "@hogehoge"
    assert @user.valid?
  end

  test "user_id validation should reject invalid address" do
    @user.user_id = "hogehoge"
    assert_not @user.valid?
  end

# 一意性
  test "user_id should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

# パスワード 
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimun length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
