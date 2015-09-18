class User
  include MongoMapper::Document

  key :email, String, :required => true
  timestamps!

  has_many :positions
end
