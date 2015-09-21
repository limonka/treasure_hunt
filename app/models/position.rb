class Position
  include MongoMapper::Document

  key :latitude, Float, required: true
  key :longitude, Float, required: true
  timestamps!

  belongs_to :user

  #TODO: add validations

  def current_position
    [latitude, longitude]
  end

  def current_position=(position)
    self.latitude, self.longitude = position.map(&:to_f)
  end

  def email=(email)
    self.user = User.first(email: email) || User.create(email: email)
  end

  def distance_to_treasure
    Geocoder::Calculations.distance_between(current_position, Treasure.current_position) * 1000
  end
end
