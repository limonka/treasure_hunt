require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test "position is valid with valid attributes" do
    assert @user.valid?
  end

  test 'position is invalid if email does not exist' do
    @user.email = nil
    assert @user.invalid?
    assert @user.errors[:email].present?
  end

  test 'position is invalid if email is not uniq' do
    new_user = create(:user)
    @user.email = new_user.email
    assert @user.invalid?
    assert @user.errors[:email].present?
  end
end
