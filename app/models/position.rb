class Position
  include MongoMapper::Document

  key :latitude, Float, required: true
  key :longitude, Float, required: true
  timestamps!

  belongs_to :user

  after_create :check_if_treasure_found

  #TODO: add format validations to lat, long

  def current_position=(position)
    self.latitude, self.longitude = position.map(&:to_f)
  end

  def current_position
    [latitude, longitude]
  end

  def email=(email)
    self.user = User.first(email: email) || User.create(email: email)
  end

  def distance_to_treasure
    Geocoder::Calculations.distance_between(current_position, Treasure.current_position) * 1000
  end

  def check_if_treasure_found
    if distance_to_treasure < 5
      user.update_attribute(:found_treasure, true)
      # TreasureFoundMailer.treasure_found(user).deliver
    end
  end
end
