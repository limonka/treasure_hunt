class User
  include MongoMapper::Document

  key :email, String, required: true, unique: true
  key :found_treasure, Boolean, default: false, required: true
  timestamps!

  scope :treasure_hunted, -> { where(found_treasure: true) }

  has_many :positions
end
