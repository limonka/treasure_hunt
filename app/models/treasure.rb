class Treasure
  def position
    ["50.051227 N", "19.945704 E"]
  end

  def latitude
    position.first
  end

  def longitude
    position.last
  end
end
