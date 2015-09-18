class Position
  include MongoMapper::Document

  key :latitude, String, :required => true
  key :longitude, String, :required => true

  key :user_id, ObjectId
  timestamps!

  belongs_to :user
end
