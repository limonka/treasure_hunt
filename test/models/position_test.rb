require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = build(:position)
  end

  test 'position is valid with valid attributes' do
    assert @position.valid?
  end

  test 'position is invalid without latitude' do
    @position.latitude = nil
    assert @position.invalid?
    assert @position.errors[:latitude].present?
  end

  test 'position is invalid with wrong latitude' do
    @position.latitude = -1000
    assert @position.invalid?
    assert @position.errors[:latitude].present?
  end

  test 'position is invalid without longitude' do
    @position.longitude = nil
    assert @position.invalid?
    assert @position.errors[:longitude].present?
  end

  test 'position is invalid with wrong longitude' do
    @position.longitude = -1000
    assert @position.invalid?
    assert @position.errors[:longitude].present?
  end

  test 'position is invalid if email does not exist' do
    @position.email = nil
    assert @position.invalid?
    assert @position.errors[:email].present?
  end

  test 'position is invalid if wrong email email' do
    @position.email = 'test'
    assert @position.invalid?
    assert @position.errors[:email].present?
  end

  test 'treasure_hunted returns users who found the treasure' do
    position = create(:treasure_position)
    @position.save
    assert Position.treasure_hunted.include?(position.email)
    assert !Position.treasure_hunted.include?(@position.email)
  end

  test 'email_sent_to? shoud return false if there was no email sent before' do
    assert !Position.email_sent_to?(@position.email)
  end

  test 'email_sent_to? shoud return true if the email was sent before' do
    position = create(:treasure_position)
    assert Position.email_sent_to?(position.email)
  end

  test 'current_position=(position) should set properly lat and long' do
    @position.current_position = [50.888, 20.0424]
    assert_equal 50.888, @position.latitude
    assert_equal 20.0424, @position.longitude
  end

  test 'current_position should return array of lat and long' do
    assert_equal [@position.latitude, @position.longitude], @position.current_position
  end

  test 'distance_to_treasure returns 0 if treasure found' do
    @position.current_position = Treasure.current_position
    assert_equal 0, @position.distance_to_treasure
  end
end
