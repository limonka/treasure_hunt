class Position
  include MongoMapper::Document

  key :latitude, Float, required: true
  key :longitude, Float, required: true
  key :email, String, required: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  key :is_treasure, Boolean, default: false, required: true
  timestamps!

  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  after_create :check_if_treasure_found

  def self.treasure_hunted
    self.collection.distinct(:email, { is_treasure: true })
  end

  def self.email_sent_to?(email)
    where(email: email, is_treasure: true).count > 0
  end

  def current_position=(position)
    self.latitude, self.longitude = position.map(&:to_f)
  end

  def current_position
    [latitude, longitude]
  end

  def distance_to_treasure
    Geocoder::Calculations.distance_between(current_position, Treasure.current_position) * 1000
  end

  private

  def check_if_treasure_found
    if distance_to_treasure <= 5
      TreasureFoundMailer.treasure_found(email).deliver unless Position.email_sent_to?(email)
      update_attribute(:is_treasure, true)
    end
  end
end
