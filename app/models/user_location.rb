class UserLocation
  include MongoMapper::Document

  key :latitude, String, required: true
  key :longitude, String, required: true
  key :email, String, required: true
  timestamps!

  #TODO: add validations

  def current_position
    [latitude, longitude]
  end

  def current_position=(position)
    latitude, longitude = position
  end
end
