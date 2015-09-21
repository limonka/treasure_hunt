class Treasure
  def self.current_position
    [50.051227, 19.945704]
  end

  def self.latitude
    self.current_position.first
  end

  def self.longitude
    self.current_position.last
  end
end
