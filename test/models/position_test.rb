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

  test 'position is invalid without longitude' do
    @position.longitude = nil
    assert @position.invalid?
    assert @position.errors[:longitude].present?
  end

  test 'current_position=(position) should set properly lat and long' do
    @position.current_position = [50.888, 20.0424]
    assert_equal 50.888, @position.latitude
    assert_equal 20.0424, @position.longitude
  end

  test 'current_position should return array of lat and long' do
    assert_equal [@position.latitude, @position.longitude], @position.current_position
  end

  test 'email=(email) should create a new user if does not exist' do
    @position.email = 'test@treasure.com'
    assert User.first(email: 'test@treasure.com')
  end

  test 'distance_to_treasure returns 0 if treasure found' do
    @position.current_position = Treasure.current_position
    assert_equal 0, @position.distance_to_treasure
  end
end
