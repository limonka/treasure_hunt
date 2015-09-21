require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test 'user is valid with valid attributes' do
    assert @user.valid?
  end

  test 'user is invalid if email does not exist' do
    @user.email = nil
    assert @user.invalid?
    assert @user.errors[:email].present?
  end

  test 'user is invalid if email is not uniq' do
    other_user = create(:user)
    @user.email = other_user.email
    assert @user.invalid?
    assert @user.errors[:email].present?
  end

  test 'treasure_hunted return users who found the treasure' do
    user = create(:position, latitude: Treasure.latitude, longitude: Treasure.longitude).user
    user2 = create(:position)
    assert User.treasure_hunted.include?(user)
    assert !User.treasure_hunted.include?(user2)
  end
end
